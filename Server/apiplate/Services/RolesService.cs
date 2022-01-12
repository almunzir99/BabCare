using System.Linq;
using System.Threading.Tasks;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;
using apiplate.Utils.URI;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace apiplate.Services
{
    public class RolesService : BaseRepository<Role, RoleResource>, IRolesService
    {
        public RolesService(IMapper mapper, ApiplateDbContext context, IUriService uriService) : base(mapper, context, uriService)
        {
        }

        public async Task<Role> GetRoleByTitle(string title)
        {
            return await GetDbSet().SingleOrDefaultAsync(c => c.Title.Equals(title));
        }

        protected override IQueryable<Role> GetDbSet()
        {
            return _context.Roles.Include(c => c.MessagesPermissions)
            .Include(c => c.AdminsPermissions)
            .Include(c => c.RolesPermissions)
            .Include(c => c.DeliveryPermissions)
            .Include(c => c.CustomersPermissions)
            .Include(c => c.ProductsPermisson)
            .Include(c => c.CategoriesPermisson);

        }


    }
}