using Application.DTOs;
using Application.Interfaces;
using Application.Responses;

public class lessonServices : IlessonServices
{
    private readonly ILessonRepository _lessonRepository;
    private readonly LessonDeltaAssembler _assembler;
    public lessonServices(ILessonRepository lessonRepository, LessonDeltaAssembler assembler)
    {
        _lessonRepository = lessonRepository;
        _assembler = assembler;
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

    public async Task<LessonBlockResponse> GetLessonsBlocksAsync()
    {
        var lessonBlocks = await _lessonRepository.GetLessonBlockAsync();
         var blockDtos = lessonBlocks.Select(b => new LessonBlockDto
        {
            Id = b.Id,
            LessonId = b.LessonId,
            BlockType = b.BlockType,
            SortOrder = b.SortOrder,
            Content = b.ContentJson,
            Metadata = b.MetadataJson
        }).ToList();
        return _assembler.Build(blockDtos);
    }
}