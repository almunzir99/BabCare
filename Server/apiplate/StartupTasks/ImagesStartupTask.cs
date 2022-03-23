using System;
using System.Threading;
using System.Threading.Tasks;
using apiplate.DataBase;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace apiplate.StartupTasks
{
    public class ImagesStartupTask : IStartupTask
    {
        private readonly IServiceProvider _serviceProvider;

        public ImagesStartupTask(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }

        public async Task ExecuteAsync(CancellationToken cancellationToken = default)
        {
            using (var scope = _serviceProvider.CreateScope())
            {
                var configuration = scope.ServiceProvider.GetRequiredService<IConfiguration>();
                var replaceBaseUrl = configuration.GetValue<bool>("autoReplaceBaseUrlOfImages");
                if (replaceBaseUrl == false)
                    return;
                var baseUrl = configuration.GetValue<string>("baseUrl");
                var dbContext = scope.ServiceProvider.GetRequiredService<ApiplateDbContext>();
                var images = await dbContext.Image.ToListAsync();
                foreach (var image in images)
                {
                    if (image.Path != null)
                    {
                        var uri = new Uri(image.Path);
                        var oldBaseUrl = uri.GetLeftPart(System.UriPartial.Authority);
                        image.Path = image.Path.Replace(oldBaseUrl, baseUrl);
                    }
                }
                await dbContext.SaveChangesAsync();

            }
        }
    }
}