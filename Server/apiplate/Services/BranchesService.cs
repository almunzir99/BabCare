using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Utils.URI;
using AutoMapper;

namespace apiplate.Services
{
    public class BranchesService : BaseRepository<Branch, BranchResource>, IBranchesService
    {
        public BranchesService(IMapper mapper, ApiplateDbContext context, IUriService uriSerivce) : base(mapper, context, uriSerivce)
        {
        }

    }
}