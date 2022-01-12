using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Utils.URI;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    [ApiController]
    [Route("api/products/[controller]")]
    public class OptionsController : BaseController<Option, OptionResource, IOptionsService>
    {
        private readonly IRolesService _roleService;
        public OptionsController(IOptionsService service, IUriService uriSerivce, IRolesService roleService) : base(service, uriSerivce)
        {
            _roleService = roleService;
        }
        protected async override Task<Permission> GetPermission(string title)
        {
            var role = await _roleService.GetRoleByTitle(title);
            if (role != null)
                return role.ProductsPermisson;
            else
                throw new System.Exception("Permission isn't implemented");
        }
    }

}