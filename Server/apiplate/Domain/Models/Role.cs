namespace apiplate.Domain.Models
{
    public class Role : BaseModel
    {
        public string Title { get; set; }
        public Permission MessagesPermissions { get; set; }
        public Permission AdminsPermissions { get; set; }
        public Permission RolesPermissions { get; set; }
 


    }
}