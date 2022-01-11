using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Resources
{
    public class BasicUserInformationResource : BaseResource
    {
        [Required]
        [MaxLength(30)]
        public string Username { get; set; }
        public string Email { get; set; }
        [Required]
        [RegularExpression(@"\(?\d{3}\)?-? *\d{3}-? *-?\d{4}")]
        public string Phone { get; set; }
        public string Password { get; set; }
        public string Photo { get; set; }
        public string token { get; set; }
        public IList<NotificationResource> Notifications { get; set; } = new List<NotificationResource>();


        
    }
}