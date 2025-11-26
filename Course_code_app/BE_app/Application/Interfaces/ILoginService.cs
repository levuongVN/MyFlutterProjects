using Core.Entities;

namespace Application.Interfaces;

public interface ILoginServices
{
    public Task<(bool success, string message ,User? user)> LoginAsync(string email, string password); // by email
}