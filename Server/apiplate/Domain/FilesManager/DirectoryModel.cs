using System;
using System.Collections.Generic;

namespace apiplate.Domain.Models.FilesManager
{
    public class DirectoryModel
    {
        public string Title { get; set; }

        public double Size { get; set; }
        public string ParentDirectory { get; set; }
        public IList<FileModel> Files { get; set; } = new List<FileModel>();
        public IList<DirectoryModel> Directories { get; set; } = new List<DirectoryModel>();
        public DateTime CreatedAt { get; set; }
        public DateTime LastUpdate { get; set; }
        public DirectoryModel(string title,
        double size = 0,
        string parentDirectory = null,
         IList<FileModel> files = null,
        DateTime createdAt = default,
        DateTime lastUpdate = default, IList<DirectoryModel> directories = null)
        {
            Title = title;
            Size = size;
            ParentDirectory = parentDirectory;
            Files = files;
            CreatedAt = createdAt;
            LastUpdate = lastUpdate;
            Directories = directories;
        }

    }

}