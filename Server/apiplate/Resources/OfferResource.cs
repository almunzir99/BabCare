using System;

namespace apiplate.Resources
{
    public class OfferResource : BaseResource
    {
        public string Title { get; set; }
        public ImageResource Image { get; set; }
        public int CategoryId { get; set; }
        public CategoryResource Category { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int Discount { get; set; }

    }
}