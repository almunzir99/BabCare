using System;
using System.Collections.Generic;

namespace apiplate.Domain.Models
{
    public class Order : BaseModel{
        public IList<OrderedProduct> Products { get; set; }
        public int CustomerId { get; set; }
        public Customer Customer { get; set; }
        public int BranchId { get; set; }
        public Branch Branch { get; set; }
        public int? DeliveryId { get; set; }
        public DeliveryDriver Delivery { get; set; }
        public double DeliveryAmount { get; set; }
        public double Lat { get; set; }
        public double  Long { get; set; }
        public String Location { get; set; }
        public OrderStatus Status { get; set; }
        public String OrderFeedback { get; set; }
        public PaymentType PaymentType { get; set; }
        public bool IsPaid { get; set; }
        public double  Total { get; set; }
        
    }
}