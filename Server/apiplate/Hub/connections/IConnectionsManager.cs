using System.Collections.Generic;

namespace apiplate.Hubs.Connections
{
    public interface IConnectionsManager
    {
        void AddUserConnection(int userId, string type, string connectionId);
        void RemoveUserConnection(string connectionId);
        IList<string> GetUserConnections(int userId, string type);
    }
}