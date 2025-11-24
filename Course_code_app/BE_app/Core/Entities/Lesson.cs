namespace Core.Entities;

public class Lesson
{
    public int Id { get; set; }
    public int CourseId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? Content { get; set; }
    public int Position { get; set; }
    public string Status { get; set; } = "Chưa học";
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    
    // Navigation properties
    public Course Course { get; set; } = null!;
    public Quiz? Quiz { get; set; }
}