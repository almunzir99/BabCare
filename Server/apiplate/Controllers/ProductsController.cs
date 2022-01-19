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

namespace apiplate.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : BaseController<Product, ProductResource, IProductsService>
    {
        private readonly IRolesService _roleService;
        public ProductsController(IProductsService service, IUriService uriSerivce, IRolesService roleService) : base(service, uriSerivce)
        {
            _roleService = roleService;
        }
        [Authorize(Roles ="ADMIN")]
        [HttpPost("options/add")]
        public async Task<ActionResult> AddOption([Required][FromQuery] int productId, [Required][FromQuery] int optionId)
        {
            try
            {
                await _service.AddOption(productId, optionId);
                var response = new Response<string>(message: "option added successfully");
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response = new Response<string>(message: "failed to add option, see error below", success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);

            }
        }
        [Authorize(Roles ="ADMIN")]
        [HttpPost("addons/add")]
        public async Task<ActionResult> AddAddons([Required][FromQuery] int productId, [Required][FromQuery] int addonId)
        {
            try
            {
                await _service.AddAddon(productId, addonId);
                var response = new Response<string>(message: "addon added successfully");
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response = new Response<string>(message: "failed to addon option, see error below", success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);

            }
        }
        [Authorize(Roles ="ADMIN")]
        [HttpDelete("options/remove")]
        public async Task<ActionResult> RemoveOption([Required][FromQuery] int productId, [Required][FromQuery] int optionId)
        {
            try
            {
                await _service.RemoveOption(productId, optionId);
                var response = new Response<string>(message: "option removed successfully");
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response = new Response<string>(message: "failed to remove option, see error below", success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);

            }
        }
        [Authorize(Roles ="ADMIN")]
        [HttpDelete("addons/remove")]
        public async Task<ActionResult> RemoveAddon([Required][FromQuery] int productId, [Required][FromQuery] int addonId)
        {
            try
            {
                await _service.RemoveAddon(productId, addonId);
                var response = new Response<string>(message: "addon removed successfully");
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response = new Response<string>(message: "failed to remove addon, see error below", success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);

            }
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