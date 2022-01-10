using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;

namespace Studious.Domain.Services
{
    public interface IAdminService : IBaseUserService<Admin,AdminResource>
    {
        
    }
    
}