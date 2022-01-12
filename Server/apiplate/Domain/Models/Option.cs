using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Domain.Models
{
    public class Option : BaseModel
    {
        [Required]
        public string Title { get; set; }
        public IList<OptionValue> Values { get; set; } = new List<OptionValue>();
    }
}