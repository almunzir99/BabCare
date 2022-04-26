using System;
using System.Linq;
using System.Threading.Tasks;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Helpers;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http;
using apiplate.Extensions;
using Microsoft.AspNetCore.Hosting;
using apiplate.Services.FilesManager;
using Microsoft.AspNetCore.JsonPatch;
using apiplate.Resources.Extras;
using System.Text.Json;
using System.IO;
using apiplate.Utils.SMTP.Services;
using Microsoft.Extensions.Configuration;
using apiplate.Utils.URI;

namespace apiplate.Services
{
    public abstract class BaseUserService<TModel, TResource> :
     BaseRepository<TModel, TResource>,
     IBaseUserService<TModel, TResource>
     where TModel : BasicUserInformation
     where TResource : BasicUserInformationResource


    {
        protected abstract string type { get; }
        protected readonly IConfiguration _config;
        private readonly ISMTPService _smtpSerivce;
        private readonly IWebHostEnvironment _webhostEnvironment;
        private readonly IFilesManagerService _filesManagerService;
        private readonly IUriService _uriService;
        public BaseUserService(IMapper mapper, ApiplateDbContext context, ISMTPService smtpService, IConfiguration config, IWebHostEnvironment webhostEnvironment, IFilesManagerService filesManagerService, IUriService uriService) : base(mapper, context, uriService)
        {
            _config = config;
            _smtpSerivce = smtpService;
            _webhostEnvironment = webhostEnvironment;
            _filesManagerService = filesManagerService;
            _uriService = uriService;
        }
        public override async Task<TResource> SingleAsync(int id)
        {
            var result = await base.SingleAsync(id);
            result.Notifications = result.Notifications.OrderByDescending(c => c).ToList();
            return result;
        }
        public virtual async Task<TResource> Authenticate(AuthenticationModel model)
        {
            // Get User By Email
            var user = await GetDbSet().SingleOrDefaultAsync(c => c.Email == model.Email);
            if (user == null)
                throw new System.Exception("This account isn't available");
            //verify the password
            var verified = HashingHelper.VerifyPassword(model.Password, user.PasswordHash, user.PasswordSalt);
            if (verified == false)
                throw new System.Exception("The password isn't correct");
            var mappedUser = _mapper.Map<TModel, TResource>(user);
            //Generate Token
            var role = (mappedUser is AdminResource) ? (mappedUser as AdminResource).Role : null;
            var secretKey = _config.GetValue<string>("SecretKey:key");
            var token = JwtHelper.GenerateToken(mappedUser, type, secretKey, role);
            mappedUser.token = token;
            mappedUser.Notifications = mappedUser.Notifications.OrderByDescending(c => c.LastUpdate).ToList();
            return mappedUser;
        }
        public virtual async Task<TResource> Register(TResource user)
        {
            try
            {
                var mappedUser = _mapper.Map<TResource, TModel>(user);
                mappedUser.CreatedAt = DateTime.Now;
                mappedUser.LastUpdate = DateTime.Now;
                byte[] pHash, pSalt;
                HashingHelper.CreateHashPassword(user.Password, out pHash, out pSalt);
                mappedUser.PasswordHash = pHash;
                mappedUser.PasswordSalt = pSalt;
                await _dbSet.AddAsync(mappedUser);
                await _context.SaveChangesAsync();
                // Generate Token
                var secretKey = _config.GetValue<string>("SecretKey:key");
                var role = (mappedUser is AdminResource) ? (mappedUser as AdminResource).Role : null;
                var result = _mapper.Map<TModel, TResource>(mappedUser);
                var token = JwtHelper.GenerateToken(result, type, secretKey, role);
                result.token = token;

                return result;

            }
            catch (DbUpdateException exception)
            {

                throw new System.Exception(exception.Decode());

            }
        }
        public override async Task<TResource> UpdateAsync(int id, TResource item)
        {
            try
            {
                var result = await _dbSet.SingleOrDefaultAsync(c => c.Id == id);
                if (result == null)
                    throw new Exception("item is not found");
                _mapper.Map<TResource, TModel>(item, result);
                result.LastUpdate = DateTime.Now;
                byte[] pHash, pSalt;
                HashingHelper.CreateHashPassword(item.Password, out pHash, out pSalt);
                result.PasswordHash = pHash;
                result.PasswordSalt = pSalt;
                await _context.SaveChangesAsync();
                var mappedResult = _mapper.Map<TModel, TResource>(result);
                return mappedResult;
            }
            catch (DbUpdateException exception)
            {

                throw new System.Exception(exception.Decode());

            }
            catch (System.Exception)
            {

                throw;
            }
        }
        public async Task PasswordRecoveryRequest(string email)
        {
            var user = await _dbSet.SingleOrDefaultAsync(c => c.Email == email);
            if (user == null)
                throw new Exception("this user isn't available");
            EmailRequest recovery = new EmailRequest();
            recovery.userId = user.Id;
            recovery.ExpiredAt = DateTime.Now.AddHours(3);
            var secretKey = _config.GetValue<string>("security:key");
            var serializedObject = JsonSerializer.Serialize<EmailRequest>(recovery);
            var encryptedText = AESEncryptor.Encrypt(secretKey, serializedObject);
            var path = Path.Combine(_webhostEnvironment.WebRootPath, "assets/templates/passwordRecovery.html");
            var htmlContent = File.ReadAllText(path);
            htmlContent = htmlContent.Replace("{{passwordRecoveryLink}}", $"https://www.studious.com/password_reset?key={encryptedText}");
            await _smtpSerivce.SendMessageAsync(_config.GetValue<string>("smtp:username"), user.Email, "Password Recovery", htmlContent, MimeKit.Text.TextFormat.Html);
        }
        public async Task<TResource> GetProfileAsync(int userId)
        {
            var target = await base.SingleAsync(userId);
            return target;
        }
        public async Task PasswordRecovery(string key, string newPassword)
        {
            try
            {
                var secretKey = _config.GetValue<string>("security:key");
                var decryptedKey = AESEncryptor.Decrypt(secretKey, key);
                var emailRequestObject = JsonSerializer.Deserialize<EmailRequest>(decryptedKey);
                if (DateTime.Now.CompareTo(emailRequestObject.ExpiredAt) == 1)
                    throw new Exception("This key is expired");
                var user = await _dbSet.SingleOrDefaultAsync(c => c.Id == emailRequestObject.userId);
                if (user == null)
                    throw new Exception("this user isn't available");
                byte[] pHash, pSalt;
                HashingHelper.CreateHashPassword(newPassword, out pHash, out pSalt);
                user.PasswordHash = pHash;
                user.PasswordSalt = pSalt;
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException exception)
            {

                throw new System.Exception(exception.Decode());

            }
            catch (System.Exception e)
            {

                throw e;
            }
        }
        public async Task<TResource> UpdatePersonalInfo(int userId, JsonPatchDocument<TModel> patchDoc)
        {
            try
            {
                if (patchDoc == null)
                    throw new Exception("object shouldn't be null");
                var emailProp = patchDoc.Operations.SingleOrDefault(c => c.path == "/email");
                if (emailProp != null)
                    throw new Exception("you can't change your email");
                var user = await _dbSet.SingleOrDefaultAsync(c => c.Id == userId);
                if (user == null)
                    throw new Exception("this user isn't available");
                patchDoc.ApplyTo(user);
                await _context.SaveChangesAsync();
                var result = _mapper.Map<TModel, TResource>(user);
                return result;

            }
            catch (DbUpdateException exception)
            {

                throw new System.Exception(exception.Decode());

            }
            catch (System.Exception e)
            {

                throw e;
            }
        }

        public async Task ResetPassword(int id, string oldPassword, string newPassword)
        {
            try
            {
                var user = await _dbSet.SingleOrDefaultAsync(c => c.Id == id);
                if (user == null)
                    throw new Exception("this user isn't available");
                var validOldPassword = HashingHelper.VerifyPassword(oldPassword, user.PasswordHash, user.PasswordSalt);
                if (validOldPassword == false)
                    throw new Exception("invalid old password");
                byte[] pHash, pSalt;
                HashingHelper.CreateHashPassword(newPassword, out pHash, out pSalt);
                user.PasswordHash = pHash;
                user.PasswordSalt = pSalt;
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException exception)
            {

                throw new System.Exception(exception.Decode());

            }
            catch (System.Exception e)
            {

                throw e;
            }



        }

        public async Task<string> ChangePersonalPhoto(int id, IFormFile file)
        {
            try
            {
                var user = await _dbSet.SingleOrDefaultAsync(c => c.Id == id);
                var oldPhoto = user.Photo;
                if (user == null)
                    throw new Exception("this user isn't available");
                var result = await _filesManagerService.uploadSingleFile("assets/images/users", file);
                user.Photo = result;
                await _context.SaveChangesAsync();
                if (_filesManagerService.FileExists(oldPhoto))
                    _filesManagerService.DeleteFile(oldPhoto, "");
                return user.Photo;

            }
            catch (DbUpdateException exception)
            {

                throw new System.Exception(exception.Decode());

            }
            catch (System.Exception e)
            {

                throw e;
            }

        }
        protected override string GetSearchPropValue(TModel obj)
        {
            var type = typeof(TModel);
            var searchProp = type.GetProperties().SingleOrDefault(c => c.Name.ToLower() == "username");
            var propValue = searchProp?.GetValue(obj).ToString();
            return propValue;
        }

    }

}