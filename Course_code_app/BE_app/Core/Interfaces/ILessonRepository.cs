using Core.Entities;
public interface ILessonRepository
{
    Task<List<Lesson>> GetLessonsAsync();
    Task<List<LessonBlock>> GetLessonBlockAsync();
}