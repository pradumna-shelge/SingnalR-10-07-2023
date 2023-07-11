using BackEnd.DTOs;
using BackEnd.Models;
using Microsoft.AspNetCore.SignalR;

namespace BackEnd.Hubs
{
    public class ChatHub : Hub
    {
        private readonly ChatAppOneToOneContext _context;
        public ChatHub(ChatAppOneToOneContext context)
        {
            _context = context;
        }
        private static Dictionary<int, string> userConnectionStore = new Dictionary<int, string>();
        public async Task SendMessage( ChatMessageDto mes)
        {
            var m = new Message()
            {
                ConversationId= mes.ConversationId,
                Author= mes.Author,
                Content = mes.Content,
                Timestamp = DateTime.Now,
            };
            await _context.Messages.AddAsync(m);
            await _context.SaveChangesAsync();

            var message = new
            {
                message = m.Content,
                timestamp = m.Timestamp,
                author = m.Author
            };
            //var RecvconnId = userConnectionStore[mes.Receiver];
            //var AuthconnId = userConnectionStore[mes.Receiver];

            if (userConnectionStore.TryGetValue(mes.Receiver, out string senderConnectionId))
            {
                await Clients.Client(senderConnectionId).SendAsync("ReceiveMessage", message);
            }

            if (userConnectionStore.TryGetValue(mes.Author, out string receiverConnectionId))
            {
                await Clients.Client(receiverConnectionId).SendAsync("ReceiveMessage", message);
            }

            
            //await Clients.Client(RecvconnId).SendAsync("ReceiveMessage",  message);
            //await Clients.Client(AuthconnId).SendAsync("ReceiveMessage",  message);

            //await Clients.
        }

        public override async Task OnConnectedAsync()
        {
            string connectionId = Context.ConnectionId;
            int userId = Convert.ToInt16(Context.GetHttpContext().Request.Query["userId"]);
            Console.WriteLine($"Hello  {userId}");
            userConnectionStore[userId] = connectionId;
            await Clients.All.SendAsync("ReceiveStatus", new {
                userId,
                status=true
            });
            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception exception)
        {
            string connectionId = Context.ConnectionId;
            int user = userConnectionStore.FirstOrDefault(x => x.Value == connectionId).Key;
            if (user!=0)
            {
                Console.WriteLine("dis******************************************************************"+user);
                await Clients.All.SendAsync("ReceiveStatus", new
                {
                    userId = user,
                    status = false
                });
                userConnectionStore.Remove(user);
            }

            await base.OnDisconnectedAsync(exception);
        }
        [HubMethodName("IsUserOnline")]
        public bool IsUserOnline(int userId)
        {
            return userConnectionStore.ContainsKey(userId);
        }

    }
}
