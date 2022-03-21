
using System.Collections.Generic;
using apiplate.Resources;

namespace apiplate.Hubs.Connections {
        public class ConnectionInfo
    {
        public int UserId { get; set; }
        public BasicUserInformationResource User { get; set; }
        public string type { get; set; }
        public IList<string> ConnectionsIds { get; set; } = new List<string>();
    }
}