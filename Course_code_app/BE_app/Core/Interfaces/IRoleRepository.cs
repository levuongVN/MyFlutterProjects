using Core.Entities;

namespace Core.Interfaces;

public interface IRoleRepository
{
    Task<List<Role>> GetAllAsync();
}