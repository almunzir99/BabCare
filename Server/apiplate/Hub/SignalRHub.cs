using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace apiplate.Hubs{
    public class SignalRHub : Hub
    {
        public async Task Init(int userId,bool Initiator){
            await Clients.Others.SendAsync("init",userId,Initiator);
        }
        public async Task Signal(int userId,object signalData){
            await Clients.Others.SendAsync("signal",userId,signalData);
        }
    }
}