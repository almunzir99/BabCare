namespace apiplate.Resources
{
    public class NotificationResource : BaseResource
    {
        public string Title { get; set; }
        public string Message { get; set; }
        public string Action { get; set; }
        public string Module { get; set; }
        public string Url { get; set; }
        public bool Read { get; set; }
        public int? GroupedItem { get; set; }
    }
}