using System;

namespace apiplate.Resources
{
    public class BaseResource
    {
        public int? Id { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime LastUpdate { get; set; } = DateTime.Now;
        public int? CreatedBy { get; set; }

    }
}