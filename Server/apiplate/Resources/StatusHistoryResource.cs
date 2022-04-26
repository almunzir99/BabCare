using System;
using apiplate.Domain.Models;

namespace apiplate.Resources
{
    public class StatusHistoryResource : BaseResource
    {
        public OrderStatus Status { get; set; }
        public String Comment { get; set; }
    }
}