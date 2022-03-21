using System.Collections.Generic;
using System.Linq;

namespace apiplate.Hubs.Connections
{
    public class ConnectionsManager : IConnectionsManager
    {
        private static string userConnectionMapLocker = string.Empty;
        private static IList<ConnectionInfo> connections = new List<ConnectionInfo>();

        public void AddUserConnection(int userId, string type, string connectionId)
        {
            lock (userConnectionMapLocker)
            {
                var connection = connections.SingleOrDefault(c => c.UserId == userId && c.type.ToLower() == type.ToLower());
                if (connection == null)
                {
                    connection = new ConnectionInfo
                    {
                        UserId = userId,
                        type = type
                    };
                    connections.Add(connection);
                }
                connection.ConnectionsIds.Add(connectionId);
            }
        }
        public IList<string> GetUserConnections(int userId, string type)
        {
            IList<string> conn = new List<string>();
            lock (userConnectionMapLocker)
            {
                var target = connections.SingleOrDefault(c => c.UserId == userId && c.type.ToLower() == type.ToLower());
                if (target != null)
                    conn = target.ConnectionsIds;
            }
            return conn;
        }
        public void RemoveUserConnection(string connectionId)
        {
            lock (userConnectionMapLocker)
            {
                foreach (var connection in connections)
                {
                    if (connection.ConnectionsIds.Contains(connectionId))
                        connection.ConnectionsIds.Remove(connectionId);
                }
            }
        }
    }
}