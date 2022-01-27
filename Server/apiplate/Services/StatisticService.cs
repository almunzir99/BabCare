using System.Threading.Tasks;
using apiplate.DataBase;
using apiplate.Domain.Services;
using apiplate.Resources;
using Microsoft.EntityFrameworkCore;

namespace apiplate.Services
{
    public class StatisticsService : IStatisticsService
    {   
        private readonly ApiplateDbContext _context;

        public StatisticsService(ApiplateDbContext context)
        {
            _context = context;
        }

        public async Task<Statistics> GetStatistics()
        {
            var stats = new Statistics();
            stats.Products = await _context.Products.CountAsync();
            stats.Orders = await _context.Orders.CountAsync();
            stats.Offers = await _context.Offers.CountAsync();
            stats.Admins = await _context.Users.CountAsync();
            stats.Customers = await _context.Customers.CountAsync();
            stats.Delivery = await _context.DeliveryDrivers.CountAsync();
            stats.Branches = await _context.Branches.CountAsync();
            stats.Categories = await _context.Categories.CountAsync();

            return stats;






        }
    }
}