using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Utils.URI;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BranchesController : BaseController<Branch, BranchResource, IBranchesService>
    { 
        private readonly IRolesService _roleService;
        public BranchesController(IBranchesService service, IUriService uriSerivce, IRolesService roleService) : base(service, uriSerivce)
        {
            _roleService = roleService;
        }
        protected async override Task<Permission> GetPermission(string title)
        {
            var role = await _roleService.GetRoleByTitle(title);
            if (role != null)
                return role.BranchesPermisson;
            else
                throw new System.Exception("Permission isn't implemented");
        }
    }

    [ApiController]
    [Route("api/[controller]")]
    public class OffersController : BaseController<Offer, OfferResource, IOffersService>
    { 
        private readonly IRolesService _roleService;
        public OffersController(IOffersService service, IUriService uriSerivce, IRolesService roleService) : base(service, uriSerivce)
        {
            _roleService = roleService;
        }
        protected async override Task<Permission> GetPermission(string title)
        {
            var role = await _roleService.GetRoleByTitle(title);
            if (role != null)
                return role.OffersPermisson;
            else
                throw new System.Exception("Permission isn't implemented");
        }
    }
}