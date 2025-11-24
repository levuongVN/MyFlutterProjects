using Core.Entities;
using Core.Interfaces;
using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
public class loginRepository : ILoginRepository
{
    private readonly ApplicationDbContext _context;

    public loginRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<User> GetUserAsync(string email) // by email
    {
        return await _context.Users.FirstOrDefaultAsync(u => u.Email == email);
    }
}