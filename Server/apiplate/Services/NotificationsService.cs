using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Extensions;
using apiplate.Hubs;
using apiplate.Hubs.Connections;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;
using AutoMapper;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;

namespace apiplate.Services
{
    public class NotificationService : INotificationService
    {
        private readonly ApiplateDbContext _dbContext;
        private readonly IMapper _mapper;
        private readonly IHubContext<NotificationsHub> _hubContext;
        private readonly IConnectionsManager _connectionManager;

        public NotificationService(ApiplateDbContext dbContext, IMapper mapper, IHubContext<NotificationsHub> hubContext, IConnectionsManager connectionManager)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _hubContext = hubContext;
            _connectionManager = connectionManager;
        }

        public async Task ClearNotificationAsync(int userId, string userType)
        {
            try
            {
                var user = await GetUser(userId, userType);
                user.Notifications.Clear();
                await _dbContext.SaveChangesAsync();
            }
            catch (DbUpdateException exception)
            {
                throw new System.Exception(exception.Decode());
            }
            catch (System.Exception e)
            {

                throw e;
            }
        }

        public async Task DeleteNotificationAsync(int id)
        {
            try
            {
                var notification = await _dbContext.Notifications.SingleOrDefaultAsync(c => c.Id == id);
                if (notification == null)
                    throw new Exception("target notification isn't available");
                _dbContext.Notifications.Remove(notification);
                await _dbContext.SaveChangesAsync();

            }
            catch (DbUpdateException exception)
            {
                throw new System.Exception(exception.Decode());
            }
            catch (System.Exception e)
            {

                throw e;
            }
        }

        public async Task<IList<NotificationResource>> GetUnreadNotification(int userId, string userType, bool AutoRead)
        {
            var user = await GetUser(userId, userType);
            var notifications = user.Notifications.Where(c => c.Read == false).ToList();
            if (AutoRead == true)
            {
                foreach (var notification in notifications)
                {
                    notification.Read = true;
                }
                await _dbContext.SaveChangesAsync();
            }
            var mappedNotifications = _mapper.Map<IList<Notification>, IList<NotificationResource>>(notifications);
            return mappedNotifications;
        }

        public async Task<IList<NotificationResource>> ListNotificationsAsync(int userId, string userType, PaginationFilter filter)
        {
            var user = await GetUser(userId, userType);
            var notifications = user.Notifications.OrderByDescending(c => c.CreatedAt).ToList();
            var mappedNotifications = _mapper.Map<IList<Notification>, IList<NotificationResource>>(notifications);
            return mappedNotifications;
        }

        public async Task PushNotification(int userId, string userType, NotificationResource notification)
        {
            try
            {
                BasicUserInformation user = await GetUser(userId, userType);
                var mappedNotification = _mapper.Map<NotificationResource, Notification>(notification);
                user.Notifications.Add(mappedNotification);
                var result = _mapper.Map<Notification, NotificationResource>(mappedNotification);
                await _dbContext.SaveChangesAsync();
                await PushNotificationWithSignalR(userId, userType, result);
            }
            catch (DbUpdateException exception)
            {
                throw new System.Exception(exception.Decode());
            }
            catch (System.Exception e)
            {

                throw e;
            }

        }
        private async Task<BasicUserInformation> GetUser(int userId, string userType)
        {
            BasicUserInformation user;
            if (userType.ToLower() == "customer")
                user = await _dbContext.Customers.Include(c => c.Notifications).SingleOrDefaultAsync(c => c.Id == userId);
            else if (userType.ToLower() == "delivery")
                user = await _dbContext.DeliveryDrivers.Include(c => c.Notifications).SingleOrDefaultAsync(c => c.Id == userId);
            else if (userType.ToLower() == "admin")
                user = await _dbContext.Users.Include(c => c.Notifications).SingleOrDefaultAsync(c => c.Id == userId);
            else
                throw new Exception("userType should either student, instructor or admin");
            if (user == null)
                throw new Exception("target user isn't available");
            return user;
        }
        public async Task<NotificationResource> ReadNotification(int id)
        {
            try
            {
                var notification = await _dbContext.Notifications.SingleOrDefaultAsync(c => c.Id == id);
                if (notification == null)
                    throw new Exception("target notification isn't available");
                notification.Read = true;
                await _dbContext.SaveChangesAsync();
                var mappedNotification = _mapper.Map<Notification, NotificationResource>(notification);
                return mappedNotification;
            }
            catch (DbUpdateException exception)
            {
                throw new System.Exception(exception.Decode());
            }
            catch (System.Exception)
            {

                throw;
            }
        }


        public async Task BroadCastNotification(NotificationResource notification, string userType, IList<Func<BasicUserInformation>> conditions = null)
        {

            try
            {
                IList<BasicUserInformation> users;
                if (userType.ToLower() == "customer")
                {
                    var customer = await _dbContext.Customers.Include(c => c.Notifications).ToListAsync();
                    users = customer.Cast<BasicUserInformation>().ToList();

                }
                else if (userType.ToLower() == "delivery")
                {
                    var deliveries = await _dbContext.DeliveryDrivers.Include(c => c.Notifications).ToListAsync();
                    users = deliveries.Cast<BasicUserInformation>().ToList();


                }
                else if (userType.ToLower() == "admin")
                {
                    var admins = await _dbContext.Users.Include(c => c.Notifications).ToListAsync();
                    users = admins.Cast<BasicUserInformation>().ToList();
                }
                else
                    throw new Exception("userType should either customer, delivery or admin");
                var mappedNotification = _mapper.Map<NotificationResource, Notification>(notification);

                foreach (var user in users)
                {
                    user.Notifications.Add(mappedNotification);
                }
                await _dbContext.SaveChangesAsync();
                foreach (var user in users)
                {
                    await PushNotificationWithSignalR(user.Id, userType, notification);

                }
            }
            catch (DbUpdateException exception)
            {
                throw new System.Exception(exception.Decode());
            }
            catch (System.Exception)
            {

                throw;
            }

        }
        private async Task PushNotificationWithSignalR(int userId, string userType, NotificationResource notification)
        {
            var target = _connectionManager.GetUserConnections(userId, userType);
            foreach (var id in target)
            {
                await _hubContext.Clients.Client(id).SendAsync("recieveNotification", notification);
            }

        }
    }
}