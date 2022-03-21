using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;

namespace apiplate.Domain.Services
{
    public interface IOrderService
    {
        Task<OrderResource> CreateOrderAsync(int customerId, OrderRequestResource Order);
        Task<OrderResource> PrepareOrderAsync(int orderId, string feedBack = null);
        Task<OrderResource> AssignOrderToDeliveryAsync(int deliveryId, int orderId, string feedBack = null);
        Task<OrderResource> ConfirmOrderAsync(int orderId, string feedBack = null);
        Task<OrderResource> CancelOrderAsync(int orderId, bool customerCancel, string feedBack = null);
        Task<OrderResource> CompleteOrderAsync(int orderId, string feedBack = null);

        Task<IList<OrderResource>> ListAsync(PaginationFilter filter, IList<Func<Order, bool>> conditions = default, int? id = null, string orderBy = "LastUpdate", bool ascending = true, OrderStatus? status = null);
        Task<IList<OrderResource>> MyOrderListAsync(int customerId, PaginationFilter filter, OrderStatus? status = null);
        Task<OrderResource> SingleAsync(int id);
        double CalculateMapDistance(double p1Lat, double p1Long, double p2Lat, double p2Long);
        Task<Branch> FindNearestBranchAsync(double lat, double lng);
        Task<int> GetTotalRecords();



    }
}