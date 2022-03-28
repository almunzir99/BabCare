using System.Collections.Generic;

namespace apiplate.Resources
{
    public class CustomerResource : BasicUserInformationResource
    {
        public string Location { get; set; }
        public IList<FavoriteResource> Favorites { get; set; }

        
    }
}