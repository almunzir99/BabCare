using System;

namespace apiplate.Domain.Models
{
    public abstract class BaseModel{
        public int Id { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime LastUpdate { get; set; }
        public int? CreatedBy { get; set; }
    }
}