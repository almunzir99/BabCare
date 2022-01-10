using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using apiplate.Domain.Models.FilesManager;
using apiplate.Services.FilesManager;
using apiplate.Wrappers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace apiplate.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FilesManagerController : ControllerBase
    {
        private readonly IFilesManagerService _fileService;

        public FilesManagerController(IFilesManagerService fileService)
        {
            _fileService = fileService;
        }
        [HttpPost("upload")]
        public async Task<IActionResult> UploadFiles(IList<IFormFile> files,
         [FromQuery] string path = "")
        {
            try
            {
                var result = await _fileService.UploadMultiFiles(path, files);
                return Ok(new Response<IList<string>>(data: result));
            }
            catch (System.Exception e)
            {

                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));

            }
        }
        [HttpPost("directories")]
        public IActionResult CreateDirectory([Required][FromQuery] string DirectoryName,
        [FromQuery] string path = "")
        {
            try
            {
                _fileService.CreateDirectory(path: path, directoryName: DirectoryName);
                return Ok(new Response<string>(message: "Directory created Successfully"));

            }
            catch (System.Exception e)
            {

                return BadRequest(new Response<string[]>(success: false,
                 errors: new string[] { e.Message }));

            }
        }
        [HttpGet("directories")]
        public IActionResult GetDirectories([FromQuery] string path = "")
        {
            try
            {
                var result = _fileService.GetAllDirectories(path);
                return Ok(new Response<IList<DirectoryModel>>(data: result));

            }
            catch (Exception e)
            {
                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));
            }

        }
        [HttpGet("directories/single")]
        public IActionResult GetDirectory([FromQuery] string path = "")
        {
            try
            {
                var result = _fileService.GetDirectory(path);
                return Ok(new Response<DirectoryModel>(data: result));

            }
            catch (Exception e)
            {
                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));
            }

        }

        [HttpGet("files")]
        public IActionResult GetFiles([FromQuery] string path = "")
        {
            try
            {
                var result = _fileService.GetAllFiles(path);
                return Ok(new Response<IList<FileModel>>(data: result));

            }
            catch (System.Exception e)
            {

                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));

            }
        }
        [HttpDelete("files")]
        public IActionResult DeleteFile([Required][FromQuery] string fileName,
        [FromQuery] string path = "")
        {
            try
            {
                _fileService.DeleteFile(path, fileName);
                return Ok(new Response<string>(message: "File Deleted Successfully"));

            }
            catch (System.Exception e)
            {

                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));

            }
        }
        [HttpDelete("directories")]
        public IActionResult DeleteDirectory([Required][FromQuery] string DirectoryName,
                [FromQuery] string path = "")
        {
            try
            {
                _fileService.DeleteDirectory(path, DirectoryName);
                return Ok(new Response<string>(message: "Directory Deleted Successfully"));

            }
            catch (System.Exception e)
            {
                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));

            }
        }
        [HttpGet("directories/move")]
        public IActionResult MoveDirectory([Required][FromQuery] string oldPath, [Required][FromQuery] string newPath, [Required][FromQuery] string DirectoryName)
        {
            if (oldPath == "/" || oldPath == @"\")
                oldPath = "";
            if (newPath == "/" || newPath == @"\")
                newPath = "";
            try
            {
                _fileService.moveDirectory(oldPath, newPath, DirectoryName);
                return Ok(new Response<string>(message: "Directory Deleted Successfully"));

            }
            catch (System.Exception e)
            {
                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));

            }
        }
        [HttpGet("directories/rename")]
        public IActionResult RenameDirectory([Required][FromQuery] string path, [Required][FromQuery] string oldName, [Required][FromQuery] string newName)
        {
             if (path == "/" || path == @"\")
                path = "";
            
            try
            {
                _fileService.RenameDirectory(path, oldName, newDirName: newName);
                return Ok(new Response<string>(message: "Directory Deleted Successfully"));

            }
            catch (System.Exception e)
            {
                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));

            }
        }
        [HttpGet("files/move")]
        public IActionResult moveFile([Required][FromQuery] string oldPath, [Required][FromQuery] string newPath, [Required][FromQuery] string fileName)
        {
             if (oldPath == "/" || oldPath == @"\")
                oldPath = "";
            if (newPath == "/" || newPath == @"\")
                newPath = "";
            try
            {
                _fileService.moveFile(oldPath, newPath, fileName);
                return Ok(new Response<string>(message: "file moved Successfully"));

            }
            catch (System.Exception e)
            {
                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));

            }
        }
        [HttpGet("files/rename")]
        public IActionResult renameFile([Required][FromQuery] string path, [Required][FromQuery] string oldName, [Required][FromQuery] string newName)
        {
             if (path == "/" || path == @"\")
                path = "";
            try
            {
                _fileService.RenameFile(path, oldName, newName);
                return Ok(new Response<string>(message: "file renamed Successfully"));

            }
            catch (System.Exception e)
            {
                return BadRequest(new Response<string[]>(success: false,
                errors: new string[] { e.Message }));

            }
        }

    }
}