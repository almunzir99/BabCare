using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Extensions;
using apiplate.Helpers;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;
using apiplate.Utils.URI;
using apiplate.Wrappers;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {
        private readonly IOrderService _service;
        private readonly IUriService _uriService;
        private readonly IMapper _mapper;
        private readonly INotificationService _notificationService;

        public OrdersController(IOrderService service, IUriService uriService, IMapper mapper, INotificationService notificationService)
        {
            _service = service;
            _uriService = uriService;
            _mapper = mapper;
            _notificationService = notificationService;
        }
        [Authorize(Roles = "CUSTOMER")]
        [HttpPost]
        public async Task<IActionResult> PostAsync(OrderRequestResource order)
        {
            try
            {
                var customerId = GetCurrentUserId();
                var result = await _service.CreateOrderAsync(customerId, order);
                var response = new Response<OrderResource>(data: result, message: "order created successfully");
                // Push Notifications
                var notification = new NotificationResource(){
                    Title = "طلب جديد",
                    Message = $"يوجد طلب جديد برقم {result.Id} , الرجاء تفقد صفحة الطلبات",
                    Module = "ORDERS",
                    Action = "CREATE",
                    Url = $"orders/{result.Id}"
                };
                await _notificationService.BroadCastNotification(notification,"admin");
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response =
                new Response<string>(success: false, message: "failed to create order,see errors below",
                errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize(Roles = "ADMIN")]
        [HttpPost("cancel")]
        public async Task<IActionResult> CancelOrderAsync(OrderStatusRequest body)
        {
            try
            {
                var result = await _service.CancelOrderAsync(body.OrderId, false, body.feedBack);
                var response = new Response<OrderResource>(data: result, message: "order canceled successfully");
                var notification = new NotificationResource(){
                    Title = "تم الغاء الطلب",
                    Message = $"تم الغاء الطلب رقم {result.Id} من قبل الادارة, الرجاء تفقد صفحة الطلبات",
                    Module = "ORDERS",
                    Action = "CANCEL",
                    Url = $"orders"
                };
                await _notificationService.PushNotification(result.CustomerId,"customer",notification);
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response =
                new Response<string>(success: false, message: "failed to cancel order,see errors below",
                errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize(Roles = "CUSTOMER")]
        [HttpPost("customer-cancel")]
        public async Task<IActionResult> CustomerCancelOrderAsync(OrderStatusRequest body)
        {
            try
            {
                var result = await _service.CancelOrderAsync(body.OrderId, true, body.feedBack);
                var response = new Response<OrderResource>(data: result, message: "order canceled successfully");
                 var notification = new NotificationResource(){
                    Title = "طلب جديد",
                    Message = $"تم الغاء الطلب رقم {result.Id} من قبل العميل",
                    Module = "ORDERS",
                    Action = "CANCEL",
                    Url = $"orders"
                };
                await _notificationService.BroadCastNotification(notification,"admin");
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response =
                new Response<string>(success: false, message: "failed to cancel order,see errors below",
                errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize(Roles = "DELIVERY")]
        [HttpPost("complete")]
        public async Task<IActionResult> CompleteOrderAsync(OrderStatusRequest body)
        {
            try
            {
                
                var result = await _service.CompleteOrderAsync(body.OrderId, body.feedBack);
                var response = new Response<OrderResource>(data: result, message: "order completed successfully");
                  var notification = new NotificationResource(){
                    Title = "تم اكمال الطلب",
                    Message = $"تم توصيل الطلب رقم {result.Id} بنجاح",
                    Module = "ORDERS",
                    Action = "COMPELETE",
                    Url = $"orders"
                };
                await _notificationService.PushNotification(result.CustomerId,"customer",notification);
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response =
                new Response<string>(success: false, message: "failed to complete order,see errors below",
                errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize(Roles = "ADMIN")]
        public async Task<IActionResult> GetAsync([FromQuery] PaginationFilter filter = null, [FromQuery] int? id = null, [FromQuery] string orderBy = "LastUpdate", Boolean ascending = true,[FromQuery] OrderStatus? status = null)
        {

            var validFilter = (filter == null)
           ? new PaginationFilter()
           : new PaginationFilter(pageIndex: filter.PageIndex, pageSize: filter.PageSize);
            int _currentUserId = int.Parse(HttpContext.User.GetClaimValue("id"));
            var result = await _service.ListAsync(filter, new List<Func<Order, bool>>(), id, orderBy, ascending,status);
            var totalRecords = await _service.GetTotalRecords();
            return Ok(PaginationHelper.CreatePagedResponse<OrderResource>(result,
            validFilter, _uriService, totalRecords, Request.Path.Value));
        }
        [Authorize(Roles = "CUSTOMER")]
        [HttpGet("me")]
        public async Task<IActionResult> MyOrdersAsync([FromQuery] PaginationFilter filter = null, [FromQuery] OrderStatus? status = null)
        {
            var customerId = GetCurrentUserId();
            var validFilter = (filter == null)
           ? new PaginationFilter()
           : new PaginationFilter(pageIndex: filter.PageIndex, pageSize: filter.PageSize);
            int _currentUserId = int.Parse(HttpContext.User.GetClaimValue("id"));
            var result = await _service.MyOrderListAsync(customerId, filter, status);
            var totalRecords = await _service.GetTotalRecords();
            return Ok(PaginationHelper.CreatePagedResponse<OrderResource>(result,
            validFilter, _uriService, totalRecords, Request.Path.Value));
        }
         [Authorize(Roles = "DELIVERY")]
        [HttpGet("delivery/me")]
        public async Task<IActionResult> DeliveryOrdersAsync([FromQuery] PaginationFilter filter = null, [FromQuery] OrderStatus? status = null)
        {
            var deliveryId = GetCurrentUserId();
            var validFilter = (filter == null)
           ? new PaginationFilter()
           : new PaginationFilter(pageIndex: filter.PageIndex, pageSize: filter.PageSize);
            int _currentUserId = int.Parse(HttpContext.User.GetClaimValue("id"));
            var result = await _service.DeliveryOrderListAsync(deliveryId, filter, status);
            var totalRecords = await _service.GetTotalRecords();
            return Ok(PaginationHelper.CreatePagedResponse<OrderResource>(result,
            validFilter, _uriService, totalRecords, Request.Path.Value));
        }
        [Authorize]
        [HttpGet("{orderId}")]
        public async Task<IActionResult> GetAsync(int orderId)
        {
            try
            {
                var result = await _service.SingleAsync(orderId);
                var response = new Response<OrderResource>(data: result);
                return Ok(response);

            }
            catch (System.Exception e)
            {

                var response = new Response<Order>(success: false, message:"failed to fetch the order detail" ,errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize(Roles = "ADMIN")]
        [HttpPost("confirm")]

        public async Task<IActionResult> ConfirmOrderAsync(OrderStatusRequest body)
        {
            try
            {
                var result = await _service.ConfirmOrderAsync(body.OrderId, body.feedBack);
                var response = new Response<OrderResource>(data: result, message: "order confirmed  successfully");
                  var notification = new NotificationResource(){
                    Title = "تم قبول الطلب",
                    Message = $"تم قبول الطلب رقم {result.Id}, سيتم تحضير الطلب بأسرع وقت",
                    Module = "ORDERS",
                    Action = "COMFIRM",
                    Url = $"orders"
                };
                await _notificationService.PushNotification(result.CustomerId,"customer",notification);
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response =
                new Response<string>(success: false, message: "failed to confirm order,see errors below",
                errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize(Roles = "ADMIN")]
        [HttpPost("prepare")]
        public async Task<IActionResult> PrepareOrderAsync(OrderStatusRequest body)
        {
            try
            {
                var result = await _service.PrepareOrderAsync(body.OrderId, body.feedBack);
                var response = new Response<OrderResource>(data: result, message: "order prepared successfully");
                  var notification = new NotificationResource(){
                    Title = "تم تحضير الطلب",
                    Message = $"تم تحضير الطلب رقم {result.Id}, سيتم توصيل الطلب بأسرع وقت",
                    Module = "ORDERS",
                    Action = "PREPARE",
                    Url = $"orders"
                };
                await _notificationService.PushNotification(result.CustomerId,"customer",notification);
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response =
                new Response<string>(success: false, message: "failed to prepare order,see errors below",
                errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize(Roles = "ADMIN")]
        [HttpPost("assign-delivery")]
        public async Task<IActionResult> AssignToDliveryAsync(OrderStatusRequest body)
        {
            try
            {
                var result = await _service.AssignOrderToDeliveryAsync(body.deliveryId.Value, body.OrderId, body.feedBack);
                var response = new Response<OrderResource>(data: result, message: "order assigned to delivery successfully");
                  var notification = new NotificationResource(){
                    Title = "الطلب حاليا قيد التوصيل",
                    Message = $"الطلب رقم {result.Id} قيد التوصيل, يمكنك متابعة الطلب من صفحة متابعة الطلب",
                    Module = "ORDERS",
                    Action = "DELIVERY",
                    Url = $"orders"
                };
                await _notificationService.PushNotification(result.CustomerId,"customer",notification);
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response =
                new Response<string>(success: false, message: "failed to complete operation,see errors below",
                errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        [HttpGet("nearest-branch")]
        public async Task<IActionResult> GetNearestBranchInfoAsync([Required][FromQuery] double lat,[Required][FromQuery] double lng){
            try
            {
                var branch = await _service.FindNearestBranchAsync(lat,lng);
                var mappedBranch = _mapper.Map<Branch,BranchResource>(branch);
                var distance = _service.CalculateMapDistance(lat,lng,branch.Lat,branch.Long);
                var result = new NearestBranchLocationInfo(){
                    nearestBranch = mappedBranch,
                    Distance = distance,
                };
                var response = new Response<NearestBranchLocationInfo>(data:result);
                return Ok(response);
            }
            catch (System.Exception e)
            {
                
                var response =
                new Response<string>(success: false, message: "failed to complete operation,see errors below",
                errors: new List<string>() { e.Message });
                return BadRequest(response);
            }
        }
        protected int GetCurrentUserId()
        {
            int _currentUserId = int.Parse(HttpContext.User.GetClaimValue("id"));
            return _currentUserId;
        }
        protected string GetCurrentUserType()
        {
            string type = HttpContext.User.GetClaimValue("http://schemas.microsoft.com/ws/2008/06/identity/claims/role");
            return type;
        }
    }

}