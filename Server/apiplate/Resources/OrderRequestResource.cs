using System;
using System.Collections.Generic;
using apiplate.Domain.Models;

namespace apiplate.Resources
{
    public class OrderRequestResource : BaseResource
    {
        public IList<OrderedProductResource> Products { get; set; } = new List<OrderedProductResource>();
        public double Lat { get; set; }
        public double Long { get; set; }
        public String Location { get; set; }
        public PaymentType PaymentType { get; set; }

    }
}