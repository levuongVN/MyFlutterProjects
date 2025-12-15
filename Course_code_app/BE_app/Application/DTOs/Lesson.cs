namespace Application.DTOs;

public class LessonDto
{
    public int Id { get; set; }
    public int CourseId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? ContentSummary { get; set; } 
    public int Position { get; set; }
    public string Status { get; set; } = "Chưa học";
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}