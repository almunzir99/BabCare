using apiplate.Domain.Models;
using apiplate.Resources;

namespace apiplate.Domain.Services
{
    public interface IOffersService : IRepository<Offer,OfferResource>{}

}