using BackEnd.DTOs;
using BackEnd.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MessageController : ControllerBase
    {
        private readonly ChatAppOneToOneContext _context;

        public MessageController(ChatAppOneToOneContext context)
        {
            _context = context;
        }
        [HttpGet("{cid}")]
        public async Task<IActionResult> getMessages(int cid)
        {
            try
            {
                var conv = await _context.Conversations.FirstOrDefaultAsync(c=>c.Id==cid);
                if(conv == null)
                {
                    return BadRequest(new { message = "Conversation not found" });
                }
                var data = from m in _context.Messages
                           where m.ConversationId == cid
                           select new
                           {
                               message = m.Content,
                               timestamp=m.Timestamp,
                               author=m.Author,
                           };
                return Ok(data);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }

            
        }
}
