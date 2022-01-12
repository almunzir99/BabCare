using System.ComponentModel.DataAnnotations;

namespace apiplate.Domain.Models
{
    public class OptionValue : BaseModel
    {
        [Required]
        public string Title { get; set; }
        [Required]
        public int Value { get; set; } 
    }
}