namespace apiplate.Domain.Models
{
    public class Favorite : BaseModel
    {
        public int ProductId { get; set; }
        public Product Product { get; set; } 
    }
}