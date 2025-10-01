namespace backend.Models;

public class Lesson
{
    public int Id { get; set; }
    public int CourseId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public int Position { get; set; } // Thứ tự bài học
    public string Status { get; set; } = "Chưa học"; // Có thể dùng enum sau
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

    // Navigation properties
    public Course Course { get; set; } = null!;
    public Quiz? Quiz { get; set; } // Một bài học có thể có một quiz (hoặc không)
}