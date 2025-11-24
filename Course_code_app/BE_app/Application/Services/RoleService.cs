using Application.DTOs;
using Application.Interfaces;
using Core.Interfaces;

namespace Application.Service;

public class RoleService : IRoleService
{
    private readonly IRoleRepository _roleRepository;

    public RoleService(IRoleRepository roleRepository)
    {
        _roleRepository = roleRepository;
    }

    public async Task<List<RoleDto>> GetAllRoles()
    {
        var roles = await _roleRepository.GetAllAsync();
        
        return roles.Select(role => new RoleDto
        {
            Id = role.Id,
            Name = role.Name,
            Description = role.Description
        }).ToList();
    }
}