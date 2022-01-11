using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace apiplate.Domain.Models
{
    public class Admin: BasicUserInformation
    {
         
        public bool IsManager { get; set; }
        public string Image { get; set; }
        [ForeignKey("Role")]
        public int? RoleId { get; set; }
        public Role Role { get; set; }
        public IList<Activity> Activities { get; set; } = new List<Activity>();
    }
}