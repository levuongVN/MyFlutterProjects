using Application.DTOs;
using Application.Interfaces;

public class lessonServices : IlessonServices
{
    private readonly ILessonRepository _lessonRepository;
    public lessonServices(ILessonRepository lessonRepository)
    {
        _lessonRepository = lessonRepository;
    }

    public async Task<List<LessonDto>> GetLessonsAsync()
    {
        var lesson = await _lessonRepository.GetLessonsAsync();
        return lesson.Select(lesson => new LessonDto
        {
            Id = lesson.Id,
            CourseId = lesson.CourseId,
            Title = lesson.Title,
            ContentSummary = lesson.ContentSummary,
            Position = lesson.Position,
            Status = lesson.Status,
            CreatedAt = lesson.CreatedAt,
            UpdatedAt = lesson.UpdatedAt,
        }).ToList();
    }

    public async Task<List<LessonBlockDto>> GetLessonsBlocksAsync()
    {
        var lessonBlocks = await _lessonRepository.GetLessonBlockAsync();

        return lessonBlocks.Select(lessonBlock => new LessonBlockDto
        {
            Id = lessonBlock.Id,
            LessonId = lessonBlock.LessonId,
            BlockType = lessonBlock.BlockType,
            SortOrder = lessonBlock.SortOrder,
            Content = lessonBlock.ContentJson,
            Metadata = lessonBlock.MetadataJson,
            Lesson = lessonBlock.Lesson != null ? new LessonDto
            {
                Id = lessonBlock.Lesson.Id,
                CourseId = lessonBlock.Lesson.CourseId,
                Title = lessonBlock.Lesson.Title,
                ContentSummary = lessonBlock.Lesson.ContentSummary,
                Position = lessonBlock.Lesson.Position,
                Status = lessonBlock.Lesson.Status,
                CreatedAt = lessonBlock.Lesson.CreatedAt,
                UpdatedAt = lessonBlock.Lesson.UpdatedAt
            } : null
        }).ToList();
    }



}