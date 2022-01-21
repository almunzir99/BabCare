using System.Collections.Generic;

namespace apiplate.Domain.Models
{
    public class OrderedProduct : BaseModel
    {
        public int ProductId { get; set; }
        public Product Product { get; set; }
        public IList<OrderedOption> OrderedOptions { get; set; }
        public IList<OrderedAddon> OrderedAddons { get; set; }
    }
}