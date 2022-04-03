using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;
using apiplate.Utils.URI;
using apiplate.Wrappers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CategoriesController : BaseController<Category, CategoryResource, ICategoriesService>
    {
        private readonly IRolesService _roleService;
        private readonly IProductsService _productsService;
        public CategoriesController(ICategoriesService service, IUriService uriSerivce, IRolesService roleService, IProductsService productsService) : base(service, uriSerivce)
        {
            _roleService = roleService;
            _productsService = productsService;
        }
        [Authorize(Roles = "ADMIN,CUSTOMER")]
        [HttpGet("{id}")]
        public override async Task<IActionResult> SingleAsync(int id)
        {
            var type = GetCurrentUserType();
            var actionResult = await base.SingleAsync(id);
            if (type == "CUSTOMER")
            {
                var customerId = GetCurrentUserId();
                var okActionResult = actionResult as OkObjectResult;
                var response = okActionResult.Value as Response<CategoryResource>;
                var category = response.Data;
                foreach (var product in category.Products)
                {
                    product.isFavorite = await _productsService.CheckIfProductIsFavAsync(customerId, product.Id.Value);

                }
                return okActionResult;
            }
            return actionResult;

        }
        [Authorize(Roles = "ADMIN,CUSTOMER")]
        [HttpGet]
        public override async Task<IActionResult> GetAsync([FromQuery] PaginationFilter filter = null, [FromQuery] string title = "", [FromQuery] string orderBy = "LastUpdate", Boolean ascending = true)
        {
            var type = GetCurrentUserType();
            var actionResult = await base.GetAsync(filter, title, orderBy, ascending);
            if (type == "CUSTOMER")
            {
                var customerId = GetCurrentUserId();
                var okActionResult = actionResult as OkObjectResult;
                var response = okActionResult.Value as Response<IList<CategoryResource>>;
                var categories = response.Data;
                foreach (var category in categories)
                {
                    foreach (var product in category.Products)
                    {
                        product.isFavorite = await _productsService.CheckIfProductIsFavAsync(customerId, product.Id.Value);

                    }
                }
                return okActionResult;
            }
            return actionResult;

        }
        protected async override Task<Permission> GetPermission(string title)
        {
            var role = await _roleService.GetRoleByTitle(title);
            if (role != null)
                return role.CategoriesPermisson;
            else
                throw new System.Exception("Permission isn't implemented");
        }
    }
}