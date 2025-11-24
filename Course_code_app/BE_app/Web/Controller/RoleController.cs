using Microsoft.AspNetCore.Mvc;
using Application.Interfaces;
using Application.DTOs;

namespace Web.Controllers;

[ApiController]
[Route("api/[controller]")]
public class RoleController : ControllerBase
{
    private readonly IRoleService _roleService;
    
    public RoleController(IRoleService roleService)
    {
        _roleService = roleService;
    }
    
    [HttpGet]
    public async Task<ActionResult<List<RoleDto>>> GetAllRoles()
    {
        var roles = await _roleService.GetAllRoles();
        return Ok(roles);
    }
}