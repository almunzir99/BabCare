using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Utils.URI;
using apiplate.Wrappers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Studious.Domain.Services;

namespace apiplate.Controllers
{
    public class CustomersController : BaseUserController<Customer, CustomerResource, ICustomerService>
    {
        private readonly IRolesService _roleService;
        public CustomersController(ICustomerService service, IUriService uriService, IRolesService roleService,INotificationService _notificationService) : base(service, uriService,_notificationService)
        {
            _roleService = roleService;
        }
        [AllowAnonymous]
        public override async Task<IActionResult> Register(CustomerResource body)
        {
            return await base.Register(body);
        }
        [Authorize(Roles = "CUSTOMER")]
        [HttpGet("favorites")]
        public async Task<IActionResult> GetFavoritesAsync()
        {
            try
            {
                var customerId = GetCurrentUserId();
                var result = await _service.GetFavoriteAsync(customerId);
                var response = new Response<IList<FavoriteResource>>(data:result,success:true,message:"data fetched successfully");
                return Ok(response);
                
            }
             catch (System.Exception e)
            {
                var response = new Response<string>(message:"failed to fetch data from a server",
                success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize(Roles = "CUSTOMER")]
        [HttpGet("favorites/add")]
        public async Task<IActionResult> AddFavoriteAsync([Required][FromQuery] int productId){
            try
            {
                var customerId = GetCurrentUserId();
                await _service.AddFavoriteAsync(customerId,productId);
                var response = new Response<string>(message:"item added successfully");
                return Ok(response);
                
                
                
            }
              catch (System.Exception e)
            {
                var response = new Response<string>(message:"failed to add data to the favorite",
                success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize(Roles = "CUSTOMER")]
        [HttpDelete("favorites/{id}")]

        public async Task<IActionResult> RemoveFavoriteAsync(int id){
            try
            {
                var customerId = GetCurrentUserId();
                await _service.RemoveFavoriteAsync(id);
                var response = new Response<string>(message:"item removed successfully");
                return Ok(response);
                
                
            }
              catch (System.Exception e)
            {
                var response = new Response<string>(message:"failed to removed data to the favorite",
                success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
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