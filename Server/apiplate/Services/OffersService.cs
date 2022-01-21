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
    public class OffersService : BaseRepository<Offer, OfferResource>, IOffersService
    {
        public OffersService(IMapper mapper, ApiplateDbContext context, IUriService uriSerivce) : base(mapper, context, uriSerivce)
        {
        }
        protected override IQueryable<Offer> GetDbSet()
        {
            return base.GetDbSet();
        }
    }
}