namespace apiplate.Domain.Models
{
    public enum OrderStatus
    {
        SENT,
        CONFIRMED,
        ON_PREPARE,
        ON_DELIVERY,
        DELIVERED,
        CANCELLED_BY_USER,
        CANCELLED_BY_RESTURANT
    }
}