using System.Threading.Tasks;
using apiplate.Resources;

namespace apiplate.Domain.Services
{
    public interface IStatisticsService
    {
        Task<Statistics> GetStatistics();
        
    }







}