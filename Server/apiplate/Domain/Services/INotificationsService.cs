using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;

namespace apiplate.Domain.Services
{
      public interface INotificationService
    {
        Task PushNotification(int userId, string userType, NotificationResource notification);
        Task<NotificationResource> ReadNotification(int id);
        Task BroadCastNotification(NotificationResource notification, string userType, IList<Func<BasicUserInformation>> conditions = null);
        Task<IList<NotificationResource>> GetUnreadNotification(int userId,string userType,bool AutoRead);
        Task<IList<NotificationResource>> ListNotificationsAsync(int userId, string userType, PaginationFilter filter);
        Task DeleteNotificationAsync(int id);
        Task ClearNotificationAsync(int userId,string userType);
        
    }
}