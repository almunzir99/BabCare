using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;
using apiplate.Extensions;
using apiplate.Helpers;
using apiplate.Utils.URI;
using apiplate.Wrappers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public abstract class BaseController<TModel, TResource, TService> : ControllerBase, IBaseController<TModel, TResource, TService>
where TModel : BaseModel where TResource : BaseResource where TService : IRepository<TModel, TResource>
    {
        protected readonly TService _service;
        protected readonly IUriService _uriSerivce;

        public BaseController(TService service, IUriService uriSerivce)
        {
            _service = service;
            _uriSerivce = uriSerivce;

        }
        [HttpPost]
        public virtual async Task<IActionResult> PostAsync([FromBody] TResource body)
        {
            if (!IsAnonymous("PostAsync") && HttpContext.User.GetClaimValue("type") != "manager")
            {
                var permission = await GetPermission(HttpContext.User.GetClaimValue("admin_role"));
                if (permission.Create == false)
                    return StatusCode(403, "Access Denied");
            }
            try
            {
                int _currentUserId = int.Parse(HttpContext.User.GetClaimValue("id"));
                var result = await _service.CreateAsync(body, _currentUserId);
                var response = new Response<TResource>(data: result);
                //create Activity
                if(!IsAnonymous("PostAsync"))
                await _service.CreateActivity(_currentUserId, result.Id.Value, "Create");
                return Ok(response);

            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [HttpDelete("{id}")]
        public virtual async Task<IActionResult> DeleteAsync(int id)
        {
            if (!IsAnonymous("DeleteAsync") && HttpContext.User.GetClaimValue("type") != "manager")
            {
                var permission = await GetPermission(HttpContext.User.GetClaimValue("admin_role"));
                if (permission.Delete == false)
                    return StatusCode(403, "Access Denied");
            }
            try
            {
                await _service.DeleteAsync(id);
                var response = new Response<TResource>(message: "Item Deleted Successfully");
                //create Activity
                int _currentUserId = int.Parse(HttpContext.User.GetClaimValue("id"));
                await _service.CreateActivity(_currentUserId, id, "Delete");
                return Ok(response);

            }
            catch (System.Exception e)
            {
                var response = new Response<TResource>(success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [HttpGet]
        public virtual async Task<IActionResult> GetAsync([FromQuery] PaginationFilter filter = null, [FromQuery] string title = "", [FromQuery] string orderBy = "LastUpdate", Boolean ascending = true)
        {
            if (!IsAnonymous("GetAsync") && HttpContext.User.GetClaimValue("type") != "manager")
            {
                var permission = await GetPermission(HttpContext.User.GetClaimValue("admin_role"));
                if (permission.Read == false)
                    return StatusCode(403, "Access Denied");
            }
            var validFilter = (filter == null)
           ? new PaginationFilter()
           : new PaginationFilter(pageIndex: filter.PageIndex, pageSize: filter.PageSize);
            int _currentUserId = int.Parse(HttpContext.User.GetClaimValue("id"));
            var result = await _service.ListAsync(filter,new List<Func<TModel,bool>>(),title, orderBy, ascending);
            var totalRecords = await _service.GetTotalRecords();
            return Ok(PaginationHelper.CreatePagedResponse<TResource>(result,
            validFilter, _uriSerivce, totalRecords, Request.Path.Value));
        }
        [HttpGet("{id}")]
        public virtual async Task<IActionResult> SingleAsync(int id)
        {
            if (!IsAnonymous("SingleAsync") && HttpContext.User.GetClaimValue("type") != "manager")
            {
                var permission = await GetPermission(HttpContext.User.GetClaimValue("admin_role"));
                if (permission.Read == false)
                    return StatusCode(403, "Access Denied");
            }
            try
            {
                var result = await _service.SingleAsync(id);
                var response = new Response<TResource>(data: result);
                return Ok(response);

            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [HttpPut("{id}")]
        public virtual async Task<IActionResult> PutAsync(int id, [FromBody] TResource body)
        {
            if (!IsAnonymous("PutAsync") && HttpContext.User.GetClaimValue("type") != "manager")
            {
                var permission = await GetPermission(HttpContext.User.GetClaimValue("admin_role"));
                if (permission.Update == false)
                    return StatusCode(403, "Access Denied");
            }
            try
            {
                var result = await _service.UpdateAsync(id, body);
                var response = new Response<TResource>(data: result);
                //create Activity
                int _currentUserId = int.Parse(HttpContext.User.GetClaimValue("id"));
                await _service.CreateActivity(_currentUserId, id, "Update");
                return Ok(response);

            }
            catch (System.Exception e)
            {
                var response = new Response<TResource>(success: false, errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        // [HttpPatch("{id}")]
        // public virtual async Task<IActionResult> PatchAsync(int id, [FromBody] JsonPatchDocument<TModel> body)
        // {
        //     if (HttpContext.User.GetClaimValue("type") != "manager")
        //     {
        //         var permission = await GetPermission(HttpContext.User.GetClaimValue("admin_role"));
        //         if (permission.Update == false)
        //             return StatusCode(403, "Access Denied");
        //     }
        //     try
        //     {
        //         var result = await _service.UpdateAsync(id, body);
        //         var response = new Response<TResource>(data: result);
        //         return Ok(response);

        //     }
        //     catch (System.Exception e)
        //     {
        //         var response = new Response<TResource>(success: false, errors: new List<string>() { e.Message });
        //         return BadRequest(response);
        //     }
        // }
        [HttpGet("export/csv")]
        public virtual async Task<IActionResult> ExportToCSV()
        {
            var result = await this._service.ExportToCSV();
            return result;

        }
        protected abstract Task<Permission> GetPermission(String role);
        private bool IsAnonymous(string name){
            var type = this.GetType();
            var targetMethod = type.GetMethods().FirstOrDefault(c => c.Name == name );
            var isAnonymous = targetMethod.GetCustomAttributes(true).SingleOrDefault(c => c.GetType().Name =="AllowAnonymousAttribute");
            return isAnonymous == null ? false : true; 
        
        }
          protected int GetCurrentUserId()
        {
            int _currentUserId = int.Parse(HttpContext.User.GetClaimValue("id"));
            return _currentUserId;
        }
        protected string GetCurrentUserType(){
            string type = HttpContext.User.GetClaimValue("http://schemas.microsoft.com/ws/2008/06/identity/claims/role");
            return type;
        }

    }
}