using Microsoft.EntityFrameworkCore;
using Core.Interfaces;
using Infrastructure.Data;
using Core.Entities;

namespace Infrastructure.Repositories;
public class RoleRepository : IRoleRepository
{
    private readonly ApplicationDbContext _context;
    
    public RoleRepository(ApplicationDbContext context)
    {
        _context = context;
    }
    
    public async Task<List<Role>> GetAllAsync()
    {
        return await _context.Roles.ToListAsync();
    }
}