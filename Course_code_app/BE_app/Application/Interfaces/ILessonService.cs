using Application.DTOs;
using Application.Responses;

namespace Application.Interfaces;

public interface IlessonServices
{
    public Task<LessonBlockResponse> GetLessonsBlocksAsync();
    public Task<List<LessonDto>> GetLessonsAsync();
}