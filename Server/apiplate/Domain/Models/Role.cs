namespace apiplate.Domain.Models
{
    public class Role : BaseModel
    {
        public string Title { get; set; }
        public Permission MessagesPermissions { get; set; }
        public Permission AdminsPermissions { get; set; }
        public Permission CustomersPermissions { get; set; }
        public Permission DeliveryPermissions { get; set; }
        public Permission RolesPermissions { get; set; }
        public Permission ProductsPermisson { get; set; }
        public Permission CategoriesPermisson { get; set; }
        public Permission BranchesPermisson { get; set; }
        public Permission OrdersPermisson { get; set; }

        public Permission OffersPermisson { get; set; }


 
    }
}