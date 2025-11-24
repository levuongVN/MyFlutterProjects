namespace Core.Entities;

public class QuizQuestion
{
    public int Id { get; set; }
    public int QuizId { get; set; }
    public string QuestionText { get; set; } = string.Empty;
    public string QuestionType { get; set; } = "multiple_choice";
    public int Points { get; set; } = 0;
    public int Position { get; set; }
    
    // Navigation properties
    public Quiz Quiz { get; set; } = null!;
    public ICollection<QuizOption> Options { get; set; } = new List<QuizOption>();
    public ICollection<UserAnswer> UserAnswers { get; set; } = new List<UserAnswer>();
}