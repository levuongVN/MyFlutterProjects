using Core.Entities;
namespace Core.Interfaces;
public interface ILoginRepository
{
    Task<User> GetUserAsync(string email);
}