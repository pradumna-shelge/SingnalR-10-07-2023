using BackEnd.DTOs;
using BackEnd.Models;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using System;

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
        public override async Task OnConnectedAsync()
        {
            string connectionId = Context.ConnectionId;
            int userId = Convert.ToInt16(Context.GetHttpContext().Request.Query["userId"]);
            Console.WriteLine($"Hello  {userId}");
            userConnectionStore[userId] = connectionId;
            await Clients.All.SendAsync("ReceiveStatus", new
            {
                userId,
                status = true
            });
            await base.OnConnectedAsync();
        }
        public async Task SendMessages( ChatMessageDto mes)
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
                author = m.Author,
                convId=mes.ConversationId,
                name=   _context.Users.ToListAsync().GetAwaiter().GetResult().FirstOrDefault(u=>u.Id==m.Author).Username,
            };

            if(mes.isGroup)
            {

                await Clients.Group("ja").SendAsync("ReceiveMessage", message);
            }
            else
            {

            if (userConnectionStore.TryGetValue(mes.Receiver, out string senderConnectionId))
            {
                await Clients.Client(senderConnectionId).SendAsync("ReceiveMessage", message);
            }

            if (userConnectionStore.TryGetValue(mes.Author, out string receiverConnectionId))
            {
                await Clients.Client(receiverConnectionId).SendAsync("ReceiveMessage", message);
            }
            }
        }

        [HubMethodName("GrpAdd")]
        public int GrpAdd(groupDto gp)
        {
            Groups.AddToGroupAsync(Context.ConnectionId, "ja");
            return 0;
        }
        

        [HubMethodName("IsUserOnline")]
        public bool IsUserOnline(int userId)
        {
            return userConnectionStore.ContainsKey(userId);
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
       



        public async Task createGroup(GroupCreateDto gp)
        {
            if(gp == null)
            {
                return;
            }

            Group g = new Group()
            {
                GroupName = gp.GroupName,
                CreatedBy = gp.CreatedBy,
                ImageUrl = gp.imageUrl
            };

            await _context.Groups.AddAsync(g);

            await _context.SaveChangesAsync();

            List<GroupMember> li = new List<GroupMember>();


            foreach(int id in gp.members)
            {
                li.Add(new GroupMember() { GroupId = g.Id,UserId= id});
            }


            await _context.GroupMembers.AddRangeAsync(li);

            await _context.SaveChangesAsync();

            var conv = new Conversation()
            {
                GroupId = g.Id
            };

            await _context.Conversations.AddAsync(conv);
            await _context.SaveChangesAsync();

            List<string> con = new List<string>();

            foreach(var p in userConnectionStore.Keys)
            {
                if(gp.members.Contains(p))
                {
                    con.Add(userConnectionStore[p]);
                }
            }

            await Clients.Clients(con).SendAsync("getConverstion");

        }




    }
}
