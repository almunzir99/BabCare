using System.Collections.Generic;
using System.Threading.Tasks;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Wrappers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    [Authorize(Roles = "ADMIN")]
    [ApiController]
    [Route("api/[controller]")]
    public class StatisticsController : ControllerBase
    {
        private readonly IStatisticsService _service;

        public StatisticsController(IStatisticsService service)
        {
            _service = service;
        }
        [HttpGet]
        public async Task<IActionResult> Get(){
            try
            {
                var stats = await  _service.GetStatistics();
                var response = new Response<Statistics>(data:stats);
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
    }

}