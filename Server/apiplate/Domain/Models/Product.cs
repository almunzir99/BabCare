using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Domain.Models
{
    public class Product : BaseModel
    {
        [Required]
        public string Title { get; set; }
        public double Price { get; set; }
        public int CategoryId { get; set; }
        public Category Category { get; set; }
        [Required]
        public string Description { get; set; }
        [Required]
        public IList<Image> Images { get; set; } = new List<Image>();
        public IList<Option> Options { get; set; } = new List<Option>();
        public IList<AddOn> AddOns { get; set; } = new List<AddOn>();
    }
}