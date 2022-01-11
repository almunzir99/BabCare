using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Domain.Models
{

    public class BasicUserInformation : BaseModel
    {
       
        [Required]
        [MaxLength(30)]
        public string Username { get; set; }
        public string Email { get; set; }
        [Required]
        [RegularExpression(@"\(?\d{3}\)?-? *\d{3}-? *-?\d{4}")]
        public string Phone { get; set; }
        [Required]
        public byte[] PasswordHash { get; set; }
        [Required]
        public byte[] PasswordSalt { get; set; }
        public string Photo { get; set; }
        public IList<Notification> Notifications { get; set; } = new List<Notification>();



    }
}