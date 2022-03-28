using System.Collections.Generic;
using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Resources;

namespace Studious.Domain.Services
{
    public interface ICustomerService : IBaseUserService<Customer,CustomerResource>
    {
        Task<IList<FavoriteResource>> GetFavoriteAsync(int customerId);
        Task AddFavoriteAsync(int customerId,int productId);
        Task RemoveFavoriteAsync(int id);
    }
    
}