using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace apiplate.Domain.Models
{
    public class Category : BaseModel
    {
        [Required]
        public string Title { get; set; }
        [Required]
        public Image Image { get; set; }
        public IList<Product> Products { get; set; } = new List<Product>();
        [ForeignKey("Offer")]
        public int? OfferId { get; set; }
        public Offer Offer { get; set; }

    }
}