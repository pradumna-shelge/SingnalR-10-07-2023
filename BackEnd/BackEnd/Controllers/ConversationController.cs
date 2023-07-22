using BackEnd.DTOs;
using BackEnd.Hubs;
using BackEnd.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;

namespace BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConversationController : ControllerBase
    {
        private readonly ChatAppOneToOneContext _context;
        private readonly IHubContext<ChatHub> _chat;

        public ConversationController(ChatAppOneToOneContext context,IHubContext<ChatHub> chat)

        {
            _context = context;
            _chat = chat;
        }

        [HttpGet("{id}")]

        public async Task<IActionResult> getConversations(int id)
        {
            try
            {
                var user = await _context.Users.FirstOrDefaultAsync(u=>u.Id == id);
                if(user == null)
                {
                    return BadRequest(new { message = "User not found" });
                }
                var convs = await _context.Conversations.ToListAsync();

                var chats = (from c in convs
                            where c.User1 == user.Id || c.User2 == user.Id
                            let ID = user.Id == c.User1 ? c.User2 : c.User1
                            select (from u in _context.Users
                                    where u.Id == ID
                                    select new
                                    {
                                        id = u.Id,
                                        name = u.Username,
                                        img = u.ImageUrl,
                                        convId = c.Id,
                                        isOnline = false,
                                        isGroup = false,

                                    }).First()).ToList();


                var groups = (from g in await _context.Groups.ToListAsync()
                             join m in await _context.GroupMembers.ToListAsync()
                             on g.Id equals m.GroupId
                             join c in await _context.Conversations.ToListAsync()
                             on g.Id equals c.GroupId
                             where m.UserId == id

                             select new
                             {
                                 id = g.Id,
                                 name = g.GroupName,
                                 img = g.ImageUrl,
                                 convId = c.Id,
                                 isOnline = false,
                                 isGroup = true,
                             }).ToList();

                var resp = chats.Concat(groups).ToList();

                return Ok(resp);

            }catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }



        [HttpPost]

        public async Task<IActionResult> createConversion(conversion con)
        {
            if(con == null)
            {
                return BadRequest(new { Message="null data" });
            }

            Conversation ncon = new Conversation()
            {
                User1 = con.user1,
                User2 = con.user2,
            };


            var flag = _context.Conversations.ToList().Find(d => (con.user1 == d.User1 && con.user2 == d.User2) || (con.user2 == d.User1 && con.user1 == d.User2));


                if (flag == null)
            {

                    await   _context.Conversations.AddAsync(ncon);
                await  _context.SaveChangesAsync();
               await _chat.Clients.All.SendAsync("getConverstion");
            }



            return Ok(new { Message = "conversion created" });
            //return Ok(flag);

        }


        }
}
