using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Utils.URI;
using Studious.Domain.Services;

namespace apiplate.Controllers
{
    public class DeliveryController : BaseUserController<DeliveryDriver, DeliveryDriverResource, IDeliveryService>
    {
        private readonly IRolesService _roleService;
        public DeliveryController(IDeliveryService service, IUriService uriService, IRolesService roleService,INotificationService _notificationService) : base(service, uriService,_notificationService)
        {
            _roleService = roleService;
        }
        protected override string type => "DELIVERY";

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