namespace Core.Entities;

public interface IRegisterRepository
{
    Task<User> addUserAsync(User user);
}