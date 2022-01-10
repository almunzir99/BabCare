using System.Linq;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Resources;
using apiplate.Services.FilesManager;
using apiplate.Utils.SMTP.Services;
using apiplate.Utils.URI;
using AutoMapper;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Studious.Domain.Services;

namespace apiplate.Services
{
    public class AdminService : BaseUserService<Admin, AdminResource>, IAdminService
    {
        public AdminService(IMapper mapper, ApiplateDbContext context, IConfiguration config, ISMTPService smtpSerivce, IWebHostEnvironment webhostEnvironment, IFilesManagerService filesManagerService,IUriService uriService) : base(mapper, context,smtpSerivce ,config,webhostEnvironment, filesManagerService,uriService)
        {
        }

        protected override string type => "ADMIN";
        protected override IQueryable<Admin> GetDbSet()
        {
            return base.GetDbSet().Include(c => c.Activities)
            .Include(c => c.Role).Include(c => c.Role);
        }
    }
}