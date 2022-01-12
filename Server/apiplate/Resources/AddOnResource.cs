using System.ComponentModel.DataAnnotations;

namespace apiplate.Resources
{
    public class AddOnResource : BaseResource
    {
        [Required]
        public string Title { get; set; }
        [Required]
        public double Price { get; set; }
    }
}