using System;
using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    public interface IBaseController<TModel, TResource, TService>
    where TModel : BaseModel where TResource : BaseResource where TService : IRepository<TModel, TResource>
    {
        Task<IActionResult> GetAsync(PaginationFilter filter = null,string title="",[FromQuery] string orderBy = "LastUpdate",Boolean ascending = true);
        Task<IActionResult> SingleAsync(int id);
        Task<IActionResult> PostAsync(TResource body);
        Task<IActionResult> PutAsync(int id, TResource body);
        Task<IActionResult> DeleteAsync(int id);
    }
}