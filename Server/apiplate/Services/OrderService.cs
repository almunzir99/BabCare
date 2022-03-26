using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Extensions;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace apiplate.Services
{
    public class OrderService : IOrderService
    {

        protected readonly ApiplateDbContext _context;
        protected readonly IMapper _mapper;
        public OrderService(IMapper mapper, ApiplateDbContext context)
        {
            _mapper = mapper;
            _context = context;
        }

        public async Task<OrderResource> AssignOrderToDeliveryAsync(int deliveryId, int orderId, string feedBack = null)
        {
            try
            {
                var order = await _context.Orders.SingleOrDefaultAsync(c => c.Id == orderId);
                if (order == null)
                    throw new Exception("the target order isn't available");
                var delivery = await _context.DeliveryDrivers.SingleOrDefaultAsync(c => c.Id == deliveryId);
                if (delivery == null)
                    throw new Exception("the target delivery driver isn't available");
                order.DeliveryId = delivery.Id;
                order.Status = OrderStatus.ON_DELIVERY;
                await _context.SaveChangesAsync();
                var result = _mapper.Map<Order, OrderResource>(order);
                return result;
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

        public async Task<OrderResource> CancelOrderAsync(int orderId, bool customerCancel = false, string feedBack = null)
        {
            try
            {
                var order = await _context.Orders.SingleOrDefaultAsync(c => c.Id == orderId);
                if (order == null)
                    throw new Exception("the target order isn't available");
                if (customerCancel)
                    order.Status = OrderStatus.CANCELLED_BY_USER;
                else
                    order.Status = OrderStatus.CANCELLED_BY_RESTURANT;
                await _context.SaveChangesAsync();
                var result = _mapper.Map<Order, OrderResource>(order);
                return result;
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

        public async Task<OrderResource> CreateOrderAsync(int customerId, OrderRequestResource order)
        {
            try
            {
                var customer = await _context.Customers.SingleOrDefaultAsync(c => c.Id == customerId);
                if (customer == null)
                    throw new System.Exception("the target customer isn't available");
                if (order.Products == null || order.Products.Count == 0)
                    throw new System.Exception("should have at least one product within the order");
                var totalPrice = 0.0;
                foreach (var oProduct in order.Products)
                {
                    var product = await _context.Products
                    .Include(c => c.AddOns)
                    .Include(c => c.Options)
                    .ThenInclude(c => c.Values)
                    .SingleOrDefaultAsync(c => c.Id == oProduct.ProductId);
                    if (product == null)
                        throw new Exception($"the product id {oProduct.ProductId} is invalid");
                    var totalProductPrice = product.Price;

                    if (oProduct.OrderedOptions.Count > 0)
                    {
                        foreach (var orderedOption in oProduct.OrderedOptions)
                        {
                            var option = product.Options.SingleOrDefault(c => product.Options.IndexOf(c) == orderedOption.OptionIndex);
                            if (option == null)
                                throw new System.Exception($"Option index {orderedOption.OptionIndex} is invalid");
                            var value = option.Values.SingleOrDefault(c => option.Values.IndexOf(c) == orderedOption.OptionValueIndex);
                            if (value == null)
                                throw new System.Exception($"Option value index {orderedOption.OptionValueIndex} is invalid");
                            totalProductPrice += value.Value;
                        }
                    }
                    if (oProduct.OrderedAddons.Count > 0)
                    {
                        foreach (var orderedAddon in oProduct.OrderedAddons)
                        {
                            var addon = product.AddOns.SingleOrDefault(c => product.AddOns.IndexOf(c) == orderedAddon.AddonIndex);
                            if (addon == null)
                                throw new System.Exception($"Option index {orderedAddon.AddonIndex} is invalid");
                            totalProductPrice += addon.Price;
                        }
                    }
                    totalPrice += totalProductPrice;

                }
                var nearestBranch = await FindNearestBranchAsync(order.Lat, order.Long);
                var distance = CalculateMapDistance(order.Lat, order.Long, nearestBranch.Lat, nearestBranch.Long);
                distance = distance / 1000.0;
                var deliveryCost = distance * nearestBranch.PricePerMeter;
                deliveryCost = Math.Round(deliveryCost);
                var newOrder = _mapper.Map<OrderRequestResource, Order>(order);
                newOrder.BranchId = nearestBranch.Id;
                newOrder.Status = OrderStatus.SENT;
                newOrder.DeliveryAmount = deliveryCost;
                newOrder.Total = totalPrice;
                newOrder.CustomerId = customerId;
                newOrder.IsPaid = false;
                _context.Orders.Add(newOrder);
                await _context.SaveChangesAsync();
                var createdOrder = await GetDbSet().SingleOrDefaultAsync(c => c.Id == newOrder.Id);
                if (createdOrder == null)
                    throw new Exception("Failed to Create order");
                var mappedOrder = _mapper.Map<Order, OrderResource>(createdOrder);
                return mappedOrder;

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

        public async Task<IList<OrderResource>> ListAsync(PaginationFilter filter, IList<Func<Order, bool>> conditions = default, int? id = null, string orderBy = "LastUpdate", bool ascending = true, OrderStatus? status = null)
        {
            try
            {
                var validFilter = (filter == null) ?
                new PaginationFilter()
                : new PaginationFilter(filter.PageIndex, filter.PageSize);
                var orders = await GetDbSet().ToListAsync();
                if (conditions != default)
                {
                    foreach (var condition in conditions)
                    {
                        orders = orders.Where(condition).ToList();
                    }
                }
                orders = orders.Where(c => (status == null) ? true : c.Status == status).ToList();
                orders = orders.Where(c => (id == null) ? true : c.Id == id).ToList();
                orders = orders
                .Skip((validFilter.PageIndex - 1) * validFilter.PageSize)
                .Take(validFilter.PageSize).ToList();
                var result = _mapper.Map<List<Order>, List<OrderResource>>(orders);
                result = OrderBy(result, orderBy, ascending);
                return result;
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

        public async Task<IList<OrderResource>> MyOrderListAsync(int customerId, PaginationFilter filter, OrderStatus? status = null)
        {
            try
            {
                var orders = await GetDbSet().Where(c => c.CustomerId == customerId).ToListAsync();
                var validFilter = (filter == null) ?
                new PaginationFilter()
                : new PaginationFilter(filter.PageIndex, filter.PageSize);
                orders = orders.Where(c => (status) == null ? true : c.Status == status).Skip((validFilter.PageIndex - 1) * validFilter.PageSize)
                .Take(validFilter.PageSize).ToList();
                orders = orders.OrderByDescending(c => c.LastUpdate).ToList();
                var mappedResult = _mapper.Map<List<Order>, List<OrderResource>>(orders);
                return mappedResult;

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
        public async Task<OrderResource> SingleAsync(int id)
        {
            try
            {
                var order = await GetDbSet().SingleOrDefaultAsync(c => c.Id == id);
                if (order == null)
                    throw new Exception("this order doesn't exist");
                var mappedOrder = _mapper.Map<Order, OrderResource>(order);
                return mappedOrder;
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
        public async Task<OrderResource> PrepareOrderAsync(int orderId, string feedBack = null)
        {
            try
            {
                var order = await _context.Orders.SingleOrDefaultAsync(c => c.Id == orderId);
                if (order == null)
                    throw new Exception("the target order isn't available");
                order.OrderFeedback = feedBack;
                order.Status = OrderStatus.ON_PREPARE;
                await _context.SaveChangesAsync();
                var result = _mapper.Map<Order, OrderResource>(order);
                return result;
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

        public async Task<OrderResource> ConfirmOrderAsync(int orderId, string feedBack = null)
        {
            try
            {
                var order = await _context.Orders.SingleOrDefaultAsync(c => c.Id == orderId);
                if (order == null)
                    throw new Exception("the target order isn't available");
                order.OrderFeedback = feedBack;
                order.Status = OrderStatus.CONFIRMED;
                await _context.SaveChangesAsync();
                var result = _mapper.Map<Order, OrderResource>(order);
                return result;
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
        public async Task<OrderResource> CompleteOrderAsync(int orderId, string feedBack = null)
        {
            try
            {
                var order = await _context.Orders.SingleOrDefaultAsync(c => c.Id == orderId);
                if (order == null)
                    throw new Exception("the target order isn't available");
                order.OrderFeedback = feedBack;
                order.Status = OrderStatus.DELIVERED;
                await _context.SaveChangesAsync();
                var result = _mapper.Map<Order, OrderResource>(order);
                return result;
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
        private List<OrderResource> OrderBy(IList<OrderResource> list, string prop, Boolean ascending)
        {
            //Get ordering Prop
            var type = typeof(OrderResource);
            var orderedList = list.OrderBy(c => c.LastUpdate).ToList();
            var orderProp = type.GetProperties().SingleOrDefault(c => c.Name.ToLower() == prop.ToLower());
            if (orderProp == null)
                throw new Exception("ordering property isn't available");
            if (ascending)
                orderedList = list.OrderBy(c => orderProp.GetValue(c, null)).ToList();
            else
                orderedList = list.OrderByDescending(c => orderProp.GetValue(c, null)).ToList();
            return orderedList;

        }
        public async Task<Branch> FindNearestBranchAsync(double lat, double lng)
        {
            var branches = await _context.Branches.ToListAsync();
            if (branches.Count == 0)
                throw new Exception("should have at least one branch to complete the operation");
            var closestBranch = branches[0];
            foreach (var branch in branches)
            {

                var closestDistance = CalculateMapDistance(lat, lng, closestBranch.Lat, closestBranch.Long);
                var distance = CalculateMapDistance(lat, lng, branch.Lat, branch.Long);
                if (distance < closestDistance)
                {
                    closestBranch = branch;
                    closestDistance = distance;
                }
            }
            return closestBranch;
        }
        public double CalculateMapDistance(double p1Lat, double p1Long, double p2Lat, double p2Long)
        {
            var R = 6378137; // Earth’s mean radius in meter
            var dLat = GetRad(p2Lat - p1Lat);
            var dLong = GetRad(p2Long - p1Long);
            var a = Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
              Math.Cos(GetRad(p1Lat)) * Math.Cos(GetRad(p2Lat)) *
              Math.Sin(dLong / 2) * Math.Sin(dLong / 2);
            var c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
            var d = R * c;
            return d;
        }
        private double GetRad(double x) => x * Math.PI / 180;
        protected virtual IQueryable<Order> GetDbSet()
        {
            return _context.Orders.Include(c => c.Branch)
            .Include(c => c.Customer).Include(c => c.Delivery).Include(c => c.Products).ThenInclude(c => c.Product).ThenInclude(c => c.Images)
            .Include(c => c.Products).ThenInclude(c => c.Product).ThenInclude(c => c.AddOns)
            .Include(c => c.Products).ThenInclude(c => c.Product).ThenInclude(c => c.Options).ThenInclude(c => c.Values)
            .Include(c => c.Products).ThenInclude(c => c.OrderedOptions)
            .Include(c => c.Products).ThenInclude(c => c.OrderedAddons);
        }

        public async Task<int> GetTotalRecords()
        {
            return await _context.Orders.CountAsync();

        }
    }
}