using Core.Entities;
using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

public class RegisterRepository : IRegisterRepository
{
    private readonly ApplicationDbContext _context;

    public RegisterRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<User> addUserAsync(User user)
    {
        _context.Users.Add(user);
        await _context.SaveChangesAsync();
        return user;
    }
}