namespace Core.Entities;

public class Course
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int LanguageId { get; set; }
    public string Level { get; set; } = string.Empty; // Beginner, Intermediate, Advanced
    public int CreatedBy { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public string Status { get; set; } = "draft"; // draft, published, archived
    
    // Navigation properties
    public Language Language { get; set; } = null!;
    public User Creator { get; set; } = null!;
    public ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>();
    public ICollection<Lesson> Lessons { get; set; } = new List<Lesson>();
}