using System.Collections.Generic;
using apiplate.Domain.Models;

namespace apiplate.Resources
{
    public class OrderedProductResource : BaseResource
    {
        
        
        public int ProductId { get; set; }
        public ProductResource Product { get; set; }
        public IList<OrderedOptionResource> OrderedOptions { get; set; } = new List<OrderedOptionResource>();
        public IList<OrderedAddonResource> OrderedAddons { get; set; } = new List<OrderedAddonResource>();
    }
}