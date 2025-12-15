namespace Application.DTOs;

public class LessonBlockDto
{
    public int Id { get; set; }
    public int? LessonId { get; set; }
    public string BlockType { get; set; } = string.Empty;
    public int SortOrder { get; set; }
    public string Content { get; set; }
    public string? Metadata { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public LessonDto? Lesson { get; set; }
}
