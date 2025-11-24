using Core.Entities;

namespace Application.Interfaces;

public interface ILoginServices
{
    public Task<User> GetUserByEmailAsync(string email); // by email
}