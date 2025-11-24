using Application.Interfaces;
using Core.Entities;
using Core.Interfaces;
namespace Application.Service;

public class LoginServices : ILoginServices
{
    private readonly ILoginRepository _loginRepository;

    public LoginServices(ILoginRepository loginRepository)
    {
        _loginRepository = loginRepository;
    }

    public async Task<User> GetUserByEmailAsync(string email)
    {
        return await _loginRepository.GetUserAsync(email);
    }
}