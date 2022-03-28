using System.Collections.Generic;

namespace apiplate.Domain.Models
{
    public class Customer : BasicUserInformation{
        
        public string Location { get; set; }
        public IList<Favorite> Favorites { get; set; }
        
    }

}