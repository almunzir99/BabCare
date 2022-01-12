using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Utils.URI;
using AutoMapper;

namespace apiplate.Services
{
    public class AddOnsService : BaseRepository<AddOn, AddOnResource>, IAddOnsService
    {
        public AddOnsService(IMapper mapper, ApiplateDbContext context, IUriService uriSerivce) : base(mapper, context, uriSerivce)
        {
        }
        
    }
}