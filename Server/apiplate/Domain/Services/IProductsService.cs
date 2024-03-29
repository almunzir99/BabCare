using System.Threading.Tasks;
using apiplate.Domain.Models;
using apiplate.Resources;

namespace apiplate.Domain.Services
{
    public interface IProductsService : IRepository<Product,ProductResource>{
        Task AddOption(int productId,int optionId);
        Task RemoveOption(int productId,int optionId);
        Task AddAddon(int productId,int addonId);
        Task RemoveAddon(int productId,int addonId);
        Task<bool> CheckIfProductIsFavAsync(int customerId,int productId);
        Task addImage(int productId, string path);
        Task removeImage(int productId, int imageId);
    }








}