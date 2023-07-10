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
            await Clients.All.SendAsync("ReceiveMessage",  message);
        }



    }
}
