namespace apiplate.Resources
{
    public class BranchResource : BaseResource
    {
        public string Title { get; set; }
        public string Location { get; set; }
        public double Lat { get; set; }
        public double Long { get; set; }
    }
}