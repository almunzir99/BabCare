using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Resources
{
    public class CategoryResource : BaseResource
    {
        [Required]
        public string Title { get; set; }
        [Required]
        public ImageResource Image { get; set; }
        public IList<ProductResource> Products { get; set; } = new List<ProductResource>();
        
    }
}