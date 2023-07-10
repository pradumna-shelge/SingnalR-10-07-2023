using BackEnd.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConversationController : ControllerBase
    {
        private readonly ChatAppOneToOneContext _context;

        public ConversationController(ChatAppOneToOneContext context)
        {
            _context = context;
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

                var resp = from c in convs
                           where c.User1 == user.Id || c.User2 == user.Id
                           let ID = user.Id == c.User1 ? c.User2 : c.User1
                           select  (from u in _context.Users where u.Id == ID
                                      select new
                                      {
                                          id = u.Id,
                                          name = u.Username,
                                          img = u.ImageUrl,
                                          convId=c.Id,
                                          isOnline=false
                                      }).First();
                

                return Ok(resp);

            }catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

    }
}
