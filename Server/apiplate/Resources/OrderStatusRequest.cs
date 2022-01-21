namespace apiplate.Resources
{
    public class OrderStatusRequest
    {   
        public int OrderId { get; set; }
        public string feedBack { get; set; }
        public int? deliveryId { get; set; }
    }
}