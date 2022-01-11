namespace apiplate.Resources
{
    public class AuthenticationModel
    {
        public string Email  { get; set; } // for admin authentication
        public string Phone { get; set; } // for delivery and customer authentication
        public string Password { get; set; }
        
    }
    
}