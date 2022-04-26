using System;

namespace apiplate.Domain.Models
{
    public class StatusHistory : BaseModel
    {
        public OrderStatus Status { get; set; }
        public String Comment { get; set; }
    }
}