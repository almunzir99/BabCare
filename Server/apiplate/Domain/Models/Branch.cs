namespace apiplate.Domain.Models
{
    public class Branch : BaseModel
    {
        public string Title { get; set; }
        public string Location { get; set; }
        public double Lat { get; set; }
        public double  Long { get; set; }
    }
}