using Microsoft.AspNetCore.Mvc;
using Application.Interfaces;
using Application.DTOs;

namespace Web.Controllers;

[ApiController]
[Route("api/[controller]")]
public class LoginController : ControllerBase
{
    private readonly ILoginServices _loginService;
    private readonly IJwtService _jwtService;
    public LoginController(ILoginServices loginServices, IJwtService jwtService)
    {
        _loginService = loginServices;
        _jwtService = jwtService;
    }
    [HttpPost]
    public async Task<ActionResult<userLoginDTO>> Login([FromBody] userLoginDTO request)
    {
        var result = await _loginService.LoginAsync(request.Email, request.Password);

        if (!result.success)
        {
            if (!result.success) return BadRequest(new { result.message });
        }
        var dto = new userLoginDTO
        {
            Id = result.user!.Id,
            Email = result.user.Email,
            RoleId = result.user.RoleId,
            FullName = result.user.FullName,
            AvatarUrl = result.user.AvatarUrl,
            Bio = result.user.Bio,
        };
        var token = _jwtService.GenerateToken(dto);
        return Ok( new{user = dto,token});
    }
}