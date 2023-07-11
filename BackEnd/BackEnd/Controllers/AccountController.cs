using BackEnd.DTOs;
using BackEnd.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly ChatAppOneToOneContext _context;

        public AccountController(ChatAppOneToOneContext context)
        {
            _context = context;
        }
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] UserLoginDto model)
        {

            var user = _context.Users.SingleOrDefault(u => u.Username == model.Username && u.Password == model.Password);
            if (user == null)
            {
                return Unauthorized();
            }
            

            return Ok(new { id=user.Id, name=user.Username, img = user.ImageUrl });
        }


        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] UserRegisterDto model)
        {
            // Check if the username already exists
            if (_context.Users.Any(u => u.Username == model.Username))
            {
                return BadRequest(new { message = "Username already exists" });
            }

            // Create a new user
            var user = new User
            {
                Username = model.Username,
                Password = model.Password,
                ImageUrl = model.ImageUrl
            };

            // Add the user to the database
            _context.Users.Add(user);
            _context.SaveChanges();

            return Ok(new { message = "Registration successful" });
        }



        [HttpGet("{id}")]

        public async Task<IActionResult> getall(int id)
        {
            var exits = (from c in _context.Conversations
                        where c.User1 == id || c.User2 == id
                        let ID = id == c.User1 ? c.User2 : c.User1
                        select (from u in _context.Users
                                where u.Id == ID
                                select u.Id).First()).ToList();

            exits.Add(id);
            var users = from u in await _context.Users.ToListAsync()
                        where ! exits.Contains(u.Id)
                        select new
                        {
                            id = u.Id,
                            name = u.Username,
                            img = u.ImageUrl
                        };
            if (users == null)
            {
                return BadRequest(new { message = "Empty Data" });
            }


             

            return Ok(users);
        }





    }
}
