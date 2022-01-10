using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Resources;

namespace apiplate.Domain.Services
{
    public interface IRolesService: IRepository<Role,RoleResource>{
        Task<Role> GetRoleByTitle(string title);
        
    }
}