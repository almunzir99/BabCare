namespace apiplate.Resources
{
    public class FavoriteResource : BaseResource
    {
          public int ProductId { get; set; }
        public ProductResource Product { get; set; } 
    }
}