namespace apiplate.Domain.Models
{
    public class Message : BaseModel
    {
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Content { get; set; }
        public string Phone { get; set; }

    }
}