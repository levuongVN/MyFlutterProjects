namespace Core.Entities;

public class QuizAttempt
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public int QuizId { get; set; }
    public DateTime? CompletedAt { get; set; }
    
    // Navigation properties
    public User User { get; set; } = null!;
    public Quiz Quiz { get; set; } = null!;
    public ICollection<UserAnswer> UserAnswers { get; set; } = new List<UserAnswer>();
}