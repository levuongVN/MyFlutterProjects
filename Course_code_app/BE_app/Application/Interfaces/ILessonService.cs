using Application.DTOs;

namespace Application.Interfaces;

public interface IlessonServices
{
    public Task<List<LessonBlockDto>> GetLessonsBlocksAsync();
    public Task<List<LessonDto>> GetLessonsAsync();
}