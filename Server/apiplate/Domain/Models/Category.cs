using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Domain.Models
{
    public class Category : BaseModel
    {
        [Required]
        public string Title { get; set; }
        [Required]
        public Image Image { get; set; }
        public IList<Product> Products { get; set; } = new List<Product>();
        
    }
}