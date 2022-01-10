using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Utils.URI;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MessagesController : BaseController<Message, MessageResource, IMessagesService>
    {
        private readonly IRolesService _roleService;
        public MessagesController(IMessagesService service, IUriService uriSerivce, IRolesService roleService) : base(service, uriSerivce)
        {
            _roleService = roleService;
        }

        [AllowAnonymous]
        [HttpPost]
        public override async Task<IActionResult> PostAsync([FromBody] MessageResource body){
            return await base.PostAsync(body);
        }
        protected async override Task<Permission> GetPermission(string title)
        {
            var role = await _roleService.GetRoleByTitle(title);
            if (role != null)
                return role.MessagesPermissions;
            else
                throw new System.Exception("Permission isn't implemented");
        }
    }

}