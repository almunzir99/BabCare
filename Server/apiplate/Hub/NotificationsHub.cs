using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using apiplate.Hubs.Connections;
using apiplate.Resources;
using Microsoft.AspNetCore.SignalR;

namespace apiplate.Hubs
{
     public class NotificationsHub : Hub
    {
        private readonly IConnectionsManager _connectionManager;

        public NotificationsHub(IConnectionsManager connectionManager)
        {
            _connectionManager = connectionManager;
        }
        public override async Task OnConnectedAsync()
        {
            
            this.GetConnectionId();
            await base.OnConnectedAsync();
        }
        public string GetConnectionId()
        {
            var httpContext = this.Context.GetHttpContext();
            var userId = httpContext.Request.Query["userId"];
            var usertype = httpContext.Request.Query["type"];
            _connectionManager.AddUserConnection(int.Parse(userId), usertype ,Context.ConnectionId);
            return Context.ConnectionId;
        }
        public async Task PushNotificationAsync(int userId,string type,NotificationResource notification)
        {
            var target = _connectionManager.GetUserConnections(userId,type);
            foreach (var id in target)
            {
                await Clients.Client(id).SendAsync("recieveNotification",notification);
            }
        }
          public async Task BroadCastNotificationAsync(IList<string> connectionsStrings,NotificationResource notification)
        {
            foreach (var id in connectionsStrings)
            {
                await Clients.Client(id).SendAsync("recieveNotification",notification);
            }
        }

        public override async Task OnDisconnectedAsync(Exception exception)
        {
            var connId = Context.ConnectionId;
            _connectionManager.RemoveUserConnection(connId);
            var value = await Task.FromResult(0);
        }
    }
    
}