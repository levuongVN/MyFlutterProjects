using System.Text.Json;
using Application.DTOs;
using Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/Register")]
public class AuthController : ControllerBase
{
    private readonly IRegisterService _registerService;

    public AuthController(IRegisterService registerService)
    {
        _registerService = registerService;
    }
    [HttpGet]
    public IActionResult Get()
    {
        return Ok("API Register is working!");
    }
    [HttpPost]
    public async Task<IActionResult> Register([FromBody] userRegisterDTO user)
    {
        try
        {

            var userEntity = new Core.Entities.User
            {
                Email = user.Email,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(user.PasswordHash),
                RoleId = user.RoleId,
                FullName = user.FullName,
                AvatarUrl = user.AvatarUrl,
                Bio = user.Bio,
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