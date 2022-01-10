using System.Collections.Generic;
using System.Threading.Tasks;
using apiplate.Domain.Models.FilesManager;
using Microsoft.AspNetCore.Http;

namespace apiplate.Services.FilesManager
{
    public interface IFilesManagerService
    {
        void CreateDirectory(string path, string directoryName);
        Task<IList<string>> UploadMultiFiles(string path, IList<IFormFile> files);
        Task<string> uploadSingleFile(string path, IFormFile file);
        IList<DirectoryModel> GetAllDirectories(string path);
        DirectoryModel GetDirectory(string path);

        IList<FileModel> GetAllFiles(string path);
        void DeleteFile(string path, string FileName);
        void DeleteDirectory(string path, string directoryName);
        void RenameDirectory(string path,string DirName,string newDirName);
        void RenameFile(string path,string fileName,string newFileName );
        void moveDirectory(string oldPath, string newPath, string directoryName);
        void moveFile(string oldPath, string newPath, string fileName);
        public bool FileExists(string path);



    }
}