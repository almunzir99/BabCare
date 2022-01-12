using System.ComponentModel.DataAnnotations;

namespace apiplate.Resources
{
    public class OptionValueResource : BaseResource
    {
        [Required]
        public string Title { get; set; }
        [Required]
        public int Value { get; set; } 
    }
}