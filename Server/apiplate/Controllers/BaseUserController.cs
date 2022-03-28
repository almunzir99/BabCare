using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;
using apiplate.Extensions;
using apiplate.Helpers;
using apiplate.Utils.URI;
using apiplate.Wrappers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Http;
using apiplate.Resources.Extras;
using System.ComponentModel.DataAnnotations;

namespace apiplate.Controllers
{
    public abstract class BaseUserController<TModel, TResource, TService>
    : BaseController<TModel, TResource, TService>
    where TModel : BasicUserInformation
    where TResource : BasicUserInformationResource
    where TService : IBaseUserService<TModel, TResource>
    {
        // private readonly INotificationService _notificationService;
        private readonly IUriService _uriService;
        protected abstract string type { get; }
        private readonly INotificationService _notificationService;
        public BaseUserController(TService service, IUriService uriService, INotificationService notificationService) : base(service, uriService)
        {
            _uriService = uriService;
            _notificationService = notificationService;
        }
        [AllowAnonymous]
        [HttpPost("Authenticate")]
        public virtual async Task<IActionResult> Authenticate(AuthenticationModel model)
        {
            try
            {
                var user = await _service.Authenticate(model);
                var response = new Response<TResource>(data: user, message: "you logged in successfuly");
                return Ok(response);
            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "logging in failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }
        }

        [HttpPost("Register")]
        public virtual async Task<IActionResult> Register(TResource body)
        {
            try
            {
                var user = await _service.Register(body);
                var response = new Response<TResource>(data: user, message: "account created successfully");
                return Ok(response);
            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "Registeration failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }
        }
        [AllowAnonymous]
        [HttpGet("password/recovery/request")]
        public virtual async Task<IActionResult> PasswordRecoveryRequest([Required][FromQuery] string email)
        {
            try
            {
                await _service.PasswordRecoveryRequest(email);
                var response = new Response<TResource>(message: "request send successfully", success: true);
                return Ok(response);

            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "operation failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }
        }
        [AllowAnonymous]
        [HttpPost("password/recovery")]
        public virtual async Task<IActionResult> PasswordRecovery(PasswordRecovery recovery)
        {
            try
            {
                await _service.PasswordRecovery(recovery.Key, recovery.NewPassword);
                var response = new Response<TResource>(message: "password resetted successfully", success: true);
                return Ok(response);

            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "operation failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize]
        [HttpPut("profile/password-reset")]
        public virtual async Task<IActionResult> PasswordReset(PasswordRecovery recovery)
        {
            var type = GetCurrentUserType();
            if (type != this.type)
                return StatusCode(403);
            try
            {
                var id = GetCurrentUserId();
                await _service.ResetPassword(id, recovery.OldPassword, recovery.NewPassword);
                var response = new Response<TResource>(message: "password resetted successfully", success: true);
                return Ok(response);

            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "operation failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize]
        [HttpPut("profile/change-photo")]
        public virtual async Task<IActionResult> ChangePersonalPhoto(IFormFile file)
        {
            var type = GetCurrentUserType();
            if (type != this.type)
                return StatusCode(403);
            try
            {
                var id = GetCurrentUserId();
                var result = await _service.ChangePersonalPhoto(id, file);
                var response = new Response<string>(data: result, message: "personal photo updated successfully", success: true);
                return Ok(response);

            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "operation failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize]
        [HttpPatch("profile/update-info")]
        public virtual async Task<IActionResult> ChangePersonalPhoto(JsonPatchDocument<TModel> body)
        {
            var type = GetCurrentUserType();
            if (type != this.type)
                return StatusCode(403);
            try
            {
                var id = GetCurrentUserId();
                var result = await _service.UpdatePersonalInfo(id, body);
                var response = new Response<TResource>(data: result, message: "personal Information updated successfully", success: true);
                return Ok(response);

            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "operation failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }
        }
        [Authorize]
        [HttpGet("profile")]
        public virtual async Task<IActionResult> GetCurrentUser()
        {
            var type = GetCurrentUserType();
            if (type != this.type)
                return StatusCode(403);
            try
            {
                var id = GetCurrentUserId();
                var result = await _service.GetProfileAsync(id);
                var response = new Response<TResource>(data: result, message: "information fetched successfully", success: true);
                return Ok(response);

            }
            catch (System.Exception e)
            {
                var response = new Response<TResource>(message: "operation failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);

            }
        }
         [HttpGet("notifications")]
        public virtual async Task<IActionResult> GetNotificationAsync([FromQuery] PaginationFilter filter)
        {
            try
            {
                var userId = GetCurrentUserId();
                if (filter == null)
                    filter = new PaginationFilter();
                var result = await _notificationService.ListNotificationsAsync(userId, type, filter);
                var response = PaginationHelper.CreatePagedResponse<NotificationResource>(
                    result, filter, _uriService, 0, Request.Path.Value
                    );
                return Ok(response);

            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "Registeration failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }
        }
        [HttpDelete("notifications/clear")]
        public virtual async Task<IActionResult> ClearNotifications()
        {
            try
            {
                var userId = GetCurrentUserId();
                await _notificationService.ClearNotificationAsync(userId, type);
                var response = new Response<string>(message: "Notifications cleared successfully");
                return Ok(response);
            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "operation failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }

        }
        [HttpDelete("notifications/{notificationId}")]
        public virtual async Task<IActionResult> DeleteNotification(int notificationId)
        {
            try
            {
                var userId = GetCurrentUserId();
                await _notificationService.DeleteNotificationAsync(notificationId);
                var response = new Response<string>(message: "Notification deleted successfully");
                return Ok(response);
            }
            catch (System.Exception e)
            {

                var response = new Response<TResource>(message: "operation failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);
            }

        }
        [HttpGet("notifications/unread")]
        public virtual async Task<IActionResult> GetUnreadNotifications([FromQuery] bool autoRead = false)
        {
            try
            {
                var userId = GetCurrentUserId();
                var result = await _notificationService.GetUnreadNotification(userId, type, autoRead);
                var response = new Response<IList<NotificationResource>>(data: result, message: "notification fetch successfully");
                return Ok(response);
            }
            catch (System.Exception e)
            {
                var response = new Response<TResource>(message: "operation failed, check errors below", success: false, errors: new[] { e.Message });
                return BadRequest(response);

            }
        }
         
}}