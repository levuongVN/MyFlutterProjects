namespace backend.Models;

public class Enrollment
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public int CourseId { get; set; }
    public float Progress { get; set; } = 0; // 0-100%
    public DateTime EnrolledAt { get; set; } = DateTime.UtcNow;
    public string Status { get; set; } = "in_progress"; // in_progress, completed, dropped

    // Navigation properties
    public User User { get; set; } = null!;
    public Course Course { get; set; } = null!;
}