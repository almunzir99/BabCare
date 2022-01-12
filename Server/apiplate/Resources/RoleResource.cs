using System.ComponentModel.DataAnnotations;

namespace apiplate.Resources
{
    public class RoleResource : BaseResource
    {

        [Required]
        public string Title { get; set; }
        public PermissionResource MessagesPermissions { get; set; } = new PermissionResource(false, false, false, false);
        public PermissionResource AdminsPermissions { get; set; } = new PermissionResource(false, false, false, false);
        public PermissionResource CustomersPermissions { get; set; } = new PermissionResource(false, false, false, false);
        public PermissionResource DeliveryPermissions { get; set; } = new PermissionResource(false, false, false, false);
        public PermissionResource RolesPermissions { get; set; } = new PermissionResource(false, false, false, false); 
        public PermissionResource ProductsPermissions { get; set; } = new PermissionResource(false, false, false, false); 
        public PermissionResource CategoriesPermissions { get; set; } = new PermissionResource(false, false, false, false); 

    }
}