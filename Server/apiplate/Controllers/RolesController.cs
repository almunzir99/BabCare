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
    public class RolesController : BaseController<Role, RoleResource, IRolesService>
    {
        private IRolesService _roleService;
        public RolesController(IRolesService service, IUriService uriService, IRolesService roleService) : base(service, uriService)
        {
            _roleService = roleService;
        }

        protected async override Task<Permission> GetPermission(string title)
        {
             var role = await _roleService.GetRoleByTitle(title);
            if(role != null)
            return role.RolesPermissions;
            else 
            throw new System.Exception("Permission isn't implemented");
        }
    }

    
}