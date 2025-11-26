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

    public async Task<(bool success, string message, User? user)> LoginAsync(string email, string password)
    {
        var user = await _loginRepository.GetUserAsync(email);
        if (user == null)
        {
            return (false, "Email không tồn tại", null);
        }
        bool isPasswordCorrect = BCrypt.Net.BCrypt.Verify(password, user.PasswordHash);

        if (!isPasswordCorrect)
        {
            return (false, "Sai Mật khẩu", null);
        }
        return (true, "", user);

    }
}