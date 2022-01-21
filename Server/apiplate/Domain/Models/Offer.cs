using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace apiplate.Domain.Models
{
public class Offer : BaseModel
{
    public string Title { get; set; }
    public Image Image { get; set; }
    public int Discount { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
}
}