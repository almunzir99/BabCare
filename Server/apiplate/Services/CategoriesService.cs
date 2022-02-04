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
    public class CategoriesService : BaseRepository<Category, CategoryResource>, ICategoriesService
    {
        public CategoriesService(IMapper mapper, ApiplateDbContext context, IUriService uriSerivce) : base(mapper, context, uriSerivce)
        {
        }
        protected override IQueryable<Category> GetDbSet()
        {
            return base.GetDbSet().Include(c => c.Products).ThenInclude(c => c.Images).Include(c => c.Image).Include(c => c.Offer);
        }
    }
}