using System.Threading;
using System.Threading.Tasks;

namespace apiplate.StartupTasks
{
    public interface IStartupTask
    {
        Task ExecuteAsync(CancellationToken cancellationToken = default);
    }
}