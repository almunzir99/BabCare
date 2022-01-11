using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Utils.URI;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Studious.Domain.Services;

namespace apiplate.Controllers
{
    public class CustomersController : BaseUserController<Customer, CustomerResource, ICustomerService>
    {
        private readonly IRolesService _roleService;
        public CustomersController(ICustomerService service, IUriService uriService, IRolesService roleService) : base(service, uriService)
        {
            _roleService = roleService;
        }
        [AllowAnonymous]
        public override async Task<IActionResult> Register(CustomerResource body)
        {
            return await base.Register(body);
        }
        protected override string type => "CUSTOMER";

        protected async override Task<Permission> GetPermission(string title)
        {
            var role = await _roleService.GetRoleByTitle(title);
            if (role != null)
                return role.AdminsPermissions;
            else
                throw new System.Exception("Permission isn't implemented");
        }
        
    }
    
}