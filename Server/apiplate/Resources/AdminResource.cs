using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using apiplate.Domain.Models;

namespace apiplate.Resources
{
    public class AdminResource : BasicUserInformationResource
    {
        public bool IsManager { get; set; }
        public IList<Activity> Activities { get; set; }
        public string Image { get; set; }
        public int? RoleId { get; set; }
        public RoleResource Role { get; set; }
    }
    
}