using Microsoft.AspNetCore.Mvc;
using Application.Interfaces;
using Application.DTOs;

namespace Web.Controllers;

[ApiController]
[Route("api/[controller]")]
public class LoginController : ControllerBase
{
    private readonly ILoginServices _loginService;
    public LoginController(ILoginServices loginServices)
    {
        _loginService = loginServices;
    }

    [HttpGet]
    public async Task<ActionResult<UserDto>> GetUserByEmail()
    {
        try
        {
            var user = await _loginService.GetUserByEmailAsync("levanvuongsg43@gmail.com");
            if (user == null)
            {
                return NotFound("User not found");
            }
            return Ok(user);
        }
        catch (Exception ex)
        {
            // Ghi log lỗi ở đây
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }
}