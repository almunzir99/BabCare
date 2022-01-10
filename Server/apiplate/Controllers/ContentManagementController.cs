using System.ComponentModel.DataAnnotations;
using apiplate.Services.ContentManagement;
using apiplate.Wrappers;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CMSController : ControllerBase
    {
        private readonly IContentManagementService _service;

        public CMSController(IContentManagementService service)
        {
            _service = service;
        }
        [HttpGet("langs")]
        public IActionResult GetLangs(){
            try
            {
                var result = _service.GetLangs();
                return Ok(result);
            }
            catch (System.Exception e)
            {
                
                return BadRequest(e);
            }
        }

        [HttpPost]
        public IActionResult CreateNewLang([Required][FromQuery]string langCode){
            try
            {
                _service.CreatNewLanguage(langCode);
                return Ok("Language File Created Successfully");
            }
            catch (System.Exception e)
            {
                
                return BadRequest(e);
            }
        }
        [HttpGet("{lang}")]
        public IActionResult GetJsonObject(string lang){
           try
           {
               var result = this._service.GetJsonObject(lang);
               return Ok(result);
           }
           catch (System.Exception e)
           {
               
               return BadRequest(new Response<string>(null,false,e.ToString(),new[] {e.ToString()}));
           } 
        }

        
        [HttpGet("{lang}/parent")]
        public IActionResult GetParent(string lang,[Required][FromQuery]string key){
           try
           {
               var result = this._service.GetParent(lang,key);
               return Ok(result);
           }
           catch (System.Exception e)
           {
               
               return BadRequest(new Response<string>(null,false,e.ToString(),new[] {e.ToString()}));
           } 
        }
        
        [HttpGet("{lang}/node")]
        public IActionResult GetNode(string lang,[Required][FromQuery]string parent,[Required][FromQuery]string key){
           try
           {
               var result = this._service.GetNode(lang,parent,key);
               return Ok(result);
           }
           catch (System.Exception e)
           {
               
               return BadRequest(new Response<string>(null,false,e.ToString(),new[] {e.ToString()}));
           } 
        }
        [HttpPost("{lang}/parent")]
        public IActionResult CreateParent(string lang,[Required][FromQuery]string name){
           try
           {
                this._service.CreateParentNode(lang,name);
               return Ok("node created successfully");
           }
           catch (System.Exception e)
           {
               
               return BadRequest(new Response<string>(null,false,e.ToString(),new[] {e.ToString()}));
           } 
        }
        [HttpPost("{lang}/node")]
        public IActionResult CreateNode(string lang,[Required][FromQuery]string parent,
        [Required][FromQuery]string key,
        [Required][FromQuery]string value){
           try
           {
                this._service.CreateNode(lang,parent,key,value);
               return Ok("node created successfully");
           }
           catch (System.Exception e)
           {
               
               return BadRequest(new Response<string>(null,false,e.ToString(),new[] {e.ToString()}));
           } 
        }
        
        [HttpPut("{lang}/node")]
        public IActionResult UpdateNode(string lang,[Required][FromQuery]string parent,
        [Required][FromQuery]string key,
        [Required][FromQuery]string value){
           try
           {
                this._service.ChangeNodeValue(lang,parent,key,value);
               return Ok("node updated successfully");
           }
           catch (System.Exception e)
           {
               
               return BadRequest(new Response<string>(null,false,e.ToString(),new[] {e.ToString()}));
           } 
        }
        
        [HttpDelete("{lang}/node")]
        public IActionResult DeleteNode(string lang,
        [Required][FromQuery]string parent,[Required][FromQuery]string key){
           try
           {
                this._service.DeleteNode(lang,parent,key);
               return Ok("node deleted successfully");
               
           }
           catch (System.Exception e)
           {
               
               return BadRequest(new Response<string>(null,false,e.ToString(),new[] {e.ToString()}));
           } 
        }
    }
}