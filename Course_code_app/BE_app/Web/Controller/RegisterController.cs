using Application.DTOs;
using Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly IRegisterService _registerService;

    public AuthController(IRegisterService registerService)
    {
        _registerService = registerService;
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] UserDto User)
    {
        try
        {
            var userEntity = new Core.Entities.User
            {
                Username = User.Username, // Sửa: dùng Username, không phải FullName
                Email = User.Email,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(User.PasswordHash),
                RoleId = User.RoleId,
                FullName = User.FullName,
                AvatarUrl = User.AvatarUrl,
                Bio = User.Bio,
                CreatedAt = DateTime.UtcNow // Thêm giá trị mặc định
            };

            var result = await _registerService.addUserAsync(userEntity);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}