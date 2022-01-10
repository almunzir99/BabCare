using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using apiplate.Domain.Models.FilesManager;
using apiplate.Utils.URI;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;

namespace apiplate.Services.FilesManager
{
    public class FilesManagerService : IFilesManagerService
    {
        private IUriService _uriService;
        private IWebHostEnvironment _webHostingEnvironment;

        public FilesManagerService(IWebHostEnvironment webHostingEnvironment, IUriService uriService)
        {
            _webHostingEnvironment = webHostingEnvironment;
            _uriService = uriService;
        }

        public void CreateDirectory(string path, string directoryName)
        {
            var combinedPath = Path.Combine(this._webHostingEnvironment.WebRootPath, path, directoryName);
            if (!Directory.Exists(combinedPath))
                Directory.CreateDirectory(combinedPath);
        }

        public void DeleteDirectory(string path, string directoryName)
        {
            var combinedPath = Path.Combine(this._webHostingEnvironment.WebRootPath, path, directoryName);
            if (Directory.Exists(combinedPath))
            {
                var files = Directory.GetFiles(combinedPath);
                var directories = Directory.GetDirectories(combinedPath);

                if (files.Length != 0)
                    foreach (var file in files)
                    {
                        this.DeleteFile(combinedPath, Path.GetFileName(file));
                    }
                if (directories.Length != 0)
                    foreach (var directory in directories)
                    {
                        this.DeleteDirectory(combinedPath, Path.GetFileName(directory));
                    }
                Directory.Delete(combinedPath);
            }
            else
                throw new DirectoryNotFoundException($"Directory {combinedPath} is Not Found");


        }
        public bool FileExists(string path)
        {
            var combinedPath = Path.Combine(_webHostingEnvironment.WebRootPath, path);
            return File.Exists(combinedPath);
        }
        public void DeleteFile(string path, string FileName)
        {
            var combinedPath = Path.Combine(this._webHostingEnvironment.WebRootPath, path, FileName);
            if (File.Exists(combinedPath))
            {
                File.Delete(combinedPath);
            }
            else
                throw new FileNotFoundException($"File {combinedPath} is Not Found");

        }

        public IList<DirectoryModel> GetAllDirectories(string path)
        {
            var combinedPath = Path.Combine(this._webHostingEnvironment.WebRootPath,
            path);
            if (!Directory.Exists(combinedPath))
                throw new DirectoryNotFoundException($"directory {path} is not found ");
            return Directory.GetDirectories(combinedPath)
            .Select(c => this.GetDirectoryModel(combinedPath, c)).ToArray();

        }

        public IList<FileModel> GetAllFiles(string path)
        {
            var combinedPath = Path.Combine(this._webHostingEnvironment.WebRootPath, path);
            return Directory.GetFiles(combinedPath).Select(file =>
            {
                var fileModel = GetFileModel(path, file);
                return fileModel;

            }).ToArray();

        }

        public async Task<IList<string>> UploadMultiFiles(string path, IList<IFormFile> files)
        {
            var listOfPath = new List<string>();
            foreach (var file in files)
            {
                var res = await uploadSingleFile(path, file);
                listOfPath.Add(res);
            }
            return listOfPath;
        }

        public async Task<string> uploadSingleFile(string path, IFormFile file)
        {
            var fileName = System.Guid.NewGuid();
            var fileExtension = Path.GetExtension(file.FileName);
            var combinedPath = Path.Combine(this._webHostingEnvironment.WebRootPath,
             path,
             $"{fileName}{fileExtension}");
            using (var stream = new FileStream(combinedPath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }
            return $"{fileName}{fileExtension}";

        }
        private Uri GetFileUri(string fileName, string path = "")
        {
            path = (path.Equals("")) ? path : string.Concat("/", path);
            path = path.Replace("wwwroot", "");
            if (path != "/")
                path = string.Concat(path, "/");
            var uri = new Uri(string.Concat(_uriService.GetBaseUri(), path, fileName));
            return uri;

        }
        private FileModel GetFileModel(string path, string file)
        {
            var info = new FileInfo(file);
            var fileName = Path.GetFileName(file);
            var uri = this.GetFileUri(fileName, path);

            var fileModel = new FileModel(
            title: fileName,
            uri: uri.ToString(),
            parentDirectory: path,
            contentType: Path.GetExtension(file),
            size: info.Length,
            createdAt: info.CreationTime,
            info.LastWriteTime);
            return fileModel;
        }
        private DirectoryModel GetDirectoryModel(string path, string name)
        {
            var combinedPath = Path.Combine(path, name);
            var directoryInfo = new DirectoryInfo(combinedPath);
            IList<FileModel> files = Directory
            .GetFiles(combinedPath)
            .Select(file => this.GetFileModel($"{Path.GetRelativePath(_webHostingEnvironment.WebRootPath, combinedPath)}", file))
            .ToList();
            IList<DirectoryModel> directories = Directory
            .GetDirectories(combinedPath)
            .Select(dir => this.GetDirectoryModel(combinedPath, dir))
            .ToList();
            return new DirectoryModel(
                title: Path.GetFileName(name),
                size: 2,
                parentDirectory: Path.GetFileName(path),
                files: files,
                directories: directories,
                createdAt: directoryInfo.CreationTime,
                lastUpdate: directoryInfo.LastWriteTime

            );
        }

        public DirectoryModel GetDirectory(string path)
        {
            var combinedPath = Path.Combine(this._webHostingEnvironment.WebRootPath,
            path);
            if (!Directory.Exists(combinedPath))
                throw new DirectoryNotFoundException($"directory {path} is not found ");
            var fileName = Path.GetFileName(combinedPath);
            combinedPath = combinedPath.Replace(fileName, "");
            return GetDirectoryModel(combinedPath, fileName);
        }

        public void RenameDirectory(string path, string DirName, string newDirName)
        {
            var combinedPath = Path.Combine(this._webHostingEnvironment.WebRootPath,
            path);
            if (!Directory.Exists(combinedPath))
                throw new DirectoryNotFoundException($"directory {path} is not found ");
            var oldPath = Path.Combine(combinedPath, DirName);
            var newPath = Path.Combine(combinedPath, newDirName);
            Directory.Move(oldPath, newPath);


        }

        public void RenameFile(string path, string fileName, string newFileName)
        {
            var combinedPath = Path.Combine(this._webHostingEnvironment.WebRootPath,
path);
            if (!Directory.Exists(combinedPath))
                throw new FileNotFoundException($"directory {path} is not found ");
            var oldPath = Path.Combine(combinedPath, fileName);
            var newPath = Path.Combine(combinedPath, newFileName);
            File.Move(oldPath, newPath);
        }

        public void moveDirectory(string oldPath, string newPath, string directoryName)
        {
            var combinedOldPath = Path.Combine(this._webHostingEnvironment.WebRootPath,
            oldPath, directoryName);
            var combinedNewPath = Path.Combine(this._webHostingEnvironment.WebRootPath,
            newPath, directoryName);
            if (!Directory.Exists(combinedOldPath))
                throw new DirectoryNotFoundException($"directory {combinedOldPath} is not found ");
            if (!Directory.Exists(combinedOldPath))
                throw new DirectoryNotFoundException($"directory {combinedNewPath} is not found ");
            Directory.Move(combinedOldPath, combinedNewPath);
        }

        public void moveFile(string oldPath, string newPath, string fileName)
        {
            var combinedOldPath = Path.Combine(this._webHostingEnvironment.WebRootPath,
            oldPath, fileName);
            var combinedNewPath = Path.Combine(this._webHostingEnvironment.WebRootPath,
            newPath, fileName);
            if (!File.Exists(combinedOldPath))
                throw new DirectoryNotFoundException($"directory {combinedOldPath} is not found ");
            File.Move(combinedOldPath, combinedNewPath);

        }
    }
}