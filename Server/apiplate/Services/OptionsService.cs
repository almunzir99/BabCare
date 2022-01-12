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
    public class OptionsService : BaseRepository<Option, OptionResource>, IOptionsService
    {
        public OptionsService(IMapper mapper, ApiplateDbContext context, IUriService uriSerivce) : base(mapper, context, uriSerivce)
        {
        }
        protected override IQueryable<Option> GetDbSet()
        {
            return base.GetDbSet().Include(c => c.Values);
        }
        
    }
}