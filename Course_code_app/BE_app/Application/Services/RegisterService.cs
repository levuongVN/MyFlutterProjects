using Application.Interfaces;
using Core.Entities;

public class RegisterService : IRegisterService
{
    private readonly IRegisterRepository _registerRepository;
    public async Task<User> addUserAsync(User user)
    {
        return await _registerRepository.addUserAsync(user);
    }
}