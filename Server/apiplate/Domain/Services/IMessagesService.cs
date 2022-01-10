using apiplate.Domain.Models;
using apiplate.Resources;

namespace apiplate.Domain.Services
{
    public interface IMessagesService : IRepository<Message,MessageResource>{}




}