using apiplate.Domain.Models;
using apiplate.Resources;

namespace apiplate.Domain.Services
{
    public interface IBranchesService : IRepository<Branch,BranchResource>{}
}