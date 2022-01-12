using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Resources
{
    public class OptionResource : BaseResource
    {
        [Required]
        public string Title { get; set; }
        public IList<OptionValueResource> Values { get; set; } = new List<OptionValueResource>();
    }
}