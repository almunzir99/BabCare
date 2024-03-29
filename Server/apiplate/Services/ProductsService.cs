using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Extensions;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;
using apiplate.Utils.URI;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace apiplate.Services
{
    public class ProductsService : BaseRepository<Product, ProductResource>, IProductsService
    {
        public ProductsService(IMapper mapper, ApiplateDbContext context, IUriService uriSerivce) : base(mapper, context, uriSerivce)
        {
        }
        public async Task AddAddon(int productId, int addonId)
        {
            try
            {
                var product = await GetDbSet().SingleAsync(c => c.Id == productId);
                if (product == null)
                    throw new System.Exception("target product isn't available");
                var addon = await _context.Addons.SingleAsync(o => o.Id == addonId);
                if (addon == null)
                    throw new System.Exception("target addon isn't available");
                product.AddOns.Add(addon);
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

        public async Task AddOption(int productId, int optionId)
        {
            try
            {
                var product = await GetDbSet().SingleAsync(c => c.Id == productId);
                if (product == null)
                    throw new System.Exception("target product isn't available");
                var option = await _context.Options.SingleAsync(o => o.Id == optionId);
                if (option == null)
                    throw new System.Exception("target option isn't available");
                product.Options.Add(option);
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

        public async Task RemoveAddon(int productId, int addonId)
        {
            try
            {
                var product = await GetDbSet().SingleAsync(c => c.Id == productId);
                if (product == null)
                    throw new System.Exception("target product isn't available");
                var addon = await _context.Addons.SingleAsync(o => o.Id == addonId);
                if (addon == null)
                    throw new System.Exception("target addon isn't available");
                product.AddOns.Remove(addon);
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

        public async Task RemoveOption(int productId, int optionId)
        {
            try
            {
                var product = await GetDbSet().SingleAsync(c => c.Id == productId);
                if (product == null)
                    throw new System.Exception("target product isn't available");
                var option = await _context.Options.SingleAsync(o => o.Id == optionId);
                if (option == null)
                    throw new System.Exception("target option isn't available");
                product.Options.Remove(option);
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
        public async Task addImage(int productId, string path)
        {
            try
            {
                var product = await GetDbSet().SingleAsync(c => c.Id == productId);
                if (product == null)
                    throw new System.Exception("target product isn't available");
                var image = new Image(){
                    Path = path
                };
                product.Images.Add(image);
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
        public async Task removeImage(int productId, int imageId)
        {
            try
            {
                var product = await GetDbSet().SingleAsync(c => c.Id == productId);
                if (product == null)
                    throw new System.Exception("target product isn't available");
                var image = product.Images.SingleOrDefault(c => c.Id == imageId);
                if(image != null)
                product.Images.Remove(image);
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
        
        public async Task<bool> CheckIfProductIsFavAsync(int customerId,int productId)
        {
            var customer = await _context.Customers.Include(c => c.Favorites).SingleOrDefaultAsync(c => c.Id == customerId);
            if(customer == null)
            throw new System.Exception("Invalid customer information");
            var item = customer.Favorites.SingleOrDefault(c => c.ProductId == productId);
            return item != null;
        }
        protected override IQueryable<Product> GetDbSet()
        {
            return base.GetDbSet()
            .Include(c => c.Category).ThenInclude(c => c.Offer)
            .Include(c => c.Images)
            .Include(c => c.Options).ThenInclude(c => c.Values)
            .Include(c => c.AddOns);
        }
    }
}