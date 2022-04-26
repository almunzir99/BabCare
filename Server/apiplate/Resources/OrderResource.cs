using System;
using System.Collections.Generic;
using apiplate.Domain.Models;

namespace apiplate.Resources
{
    public class OrderResource : BaseResource
    {
        public IList<OrderedProductResource> Products { get; set; }
        public int CustomerId { get; set; }
        public CustomerResource Customer { get; set; }
        public int BranchId { get; set; }
        public BranchResource Branch { get; set; }
        public int? DeliveryId { get; set; }
        public DeliveryDriverResource Delivery { get; set; }
        public double DeliveryAmount { get; set; }
        public double Lat { get; set; }
        public double Long { get; set; }
        public String Location { get; set; }
        public OrderStatus Status { get; set; }
        public IList<StatusHistoryResource> History { get; set; }
        public PaymentType PaymentType { get; set; }
        public bool IsPaid { get; set; }
        public double Total { get; set; }
    }
}