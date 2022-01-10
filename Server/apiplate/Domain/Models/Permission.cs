namespace apiplate.Domain.Models
{
    public class Permission : BaseModel{
        public bool Create { get; set; }
        public bool Read { get; set; }
        public bool Update { get; set; }
        public bool Delete { get; set; }
    }
}