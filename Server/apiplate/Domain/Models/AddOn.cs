using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Domain.Models
{
    public class AddOn : BaseModel
    {
        [Required]
        public string Title { get; set; }
        [Required]
        public double Price { get; set; }
        public IList<Product> Products { get; set; }

    }
}