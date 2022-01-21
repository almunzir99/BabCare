namespace apiplate.Domain.Models
{
    public class OrderedOption : BaseModel
    {
        public int OptionIndex { get; set; }
        public int OptionValueIndex { get; set; }
    }
}