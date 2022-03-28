using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Extensions;
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

        public async Task<IList<FavoriteResource>> GetFavoriteAsync(int customerId)
        {
            var customer = await _context.Customers.Include(c => c.Favorites)
            .ThenInclude(c => c.Product).ThenInclude(c => c.Images)
            .SingleAsync(c => c.Id == customerId);
            if (customer == null)
                throw new System.Exception("The target customer isn't available");
            var mappedResult = _mapper.Map<IList<Favorite>, List<FavoriteResource>>(customer.Favorites);
            return mappedResult;
        }

        public async Task AddFavoriteAsync(int customerId, int productId)
        {
            try
            {
                var customer = await _context.Customers.Include(c => c.Favorites)
            .SingleAsync(c => c.Id == customerId);
                if (customer == null)
                    throw new System.Exception("The target customer isn't available");
                var product = await _context.Products.SingleAsync(c => c.Id == productId);
                if (product == null)
                    throw new System.Exception("The target product isn't available");
                var fav = new Favorite()
                {
                    ProductId = productId
                };
                customer.Favorites.Add(fav);
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
        public async Task RemoveFavoriteAsync(int id)
        {
            try
            {
                var target = await _context.Favorites.SingleOrDefaultAsync(c => c.Id == id);
                if(target == null)
                throw new System.Exception("the target item isn't available");
                _context.Favorites.Remove(target);
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

        protected override string type => "CUSTOMER";

    }
}