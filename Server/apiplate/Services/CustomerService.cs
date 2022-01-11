using System.Linq;
using System.Threading.Tasks;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Helpers;
using apiplate.Resources;
using apiplate.Services.FilesManager;
using apiplate.Utils.SMTP.Services;
using apiplate.Utils.URI;
using AutoMapper;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Studious.Domain.Services;

namespace apiplate.Services
{
    public class CustomerService : BaseUserService<Customer, CustomerResource>, ICustomerService
    {
        public CustomerService(IMapper mapper, ApiplateDbContext context, IConfiguration config, ISMTPService smtpSerivce, IWebHostEnvironment webhostEnvironment, IFilesManagerService filesManagerService, IUriService uriService) : base(mapper, context, smtpSerivce, config, webhostEnvironment, filesManagerService, uriService)
        {
        }
        public override async Task<CustomerResource> Authenticate(AuthenticationModel model)
        {
            // Get User By Email
            var user = await GetDbSet().SingleOrDefaultAsync(c => c.Phone == model.Phone);
            if (user == null)
                throw new System.Exception("This account isn't available");
            //verify the password
            var verified = HashingHelper.VerifyPassword(model.Password, user.PasswordHash, user.PasswordSalt);
            if (verified == false)
                throw new System.Exception("The password isn't correct");
            var mappedUser = _mapper.Map<Customer, CustomerResource>(user);
            //Generate Token
            var secretKey = _config.GetValue<string>("SecretKey:key");
            var token = JwtHelper.GenerateToken(mappedUser, type, secretKey, null);
            mappedUser.token = token;
            mappedUser.Notifications = mappedUser.Notifications.OrderByDescending(c => c.LastUpdate).ToList();
            return mappedUser;
        }
        protected override string type => "CUSTOMER";

    }
}