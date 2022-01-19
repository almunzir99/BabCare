using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Resources
{
    public class ProductResource : BaseResource
    {
        [Required]
        public string Title { get; set; }
        public double Price { get; set; }
        public int? Discount { get; set; }
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
        [Required]
        public string Description { get; set; }
        [Required]
        public IList<ImageResource> Images { get; set; } = new List<ImageResource>();
        public IList<OptionResource> Options { get; set; } = new List<OptionResource>();
        public IList<AddOnResource> AddOns { get; set; } = new List<AddOnResource>();

    }
}