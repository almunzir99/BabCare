using System.Linq;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
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
        protected override IQueryable<Product> GetDbSet()
        {
            return base.GetDbSet().Include(c => c.Images).Include(c => c.Options).Include(c => c.AddOns);
        }
    }
}