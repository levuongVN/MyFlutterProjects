using Application.DTOs;
using Core.Entities;

namespace Application.Interfaces;

public interface IRegisterService
{
    public Task<User> addUserAsync(User user);
}