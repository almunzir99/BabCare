using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace apiplate.StartupTasks.Extensions
{
    public static class StartupTaskWebHostExtension
    {
        public static async Task RunWithTasksAsync(this IHost webHost, CancellationToken token = default)
        {
            var services = webHost.Services.GetServices<IStartupTask>();
            foreach (var service in services)
            {
                await service.ExecuteAsync(token);
            }
            await webHost.RunAsync();
        }

    }

}