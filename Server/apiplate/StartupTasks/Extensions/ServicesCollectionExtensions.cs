using Microsoft.Extensions.DependencyInjection;

namespace apiplate.StartupTasks.Extensions
{
    public static class ServiceCollectionExtension
    {
        public static IServiceCollection AddStartupTask<T>(this IServiceCollection services)
       where T : class, IStartupTask
       => services.AddTransient<IStartupTask, T>();
    }

}