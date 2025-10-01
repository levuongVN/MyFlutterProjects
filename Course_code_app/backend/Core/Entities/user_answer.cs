namespace backend.Models;

public class UserAnswer
{
    public int Id { get; set; }
    public int AttemptId { get; set; }
    public int QuestionId { get; set; }
    public int SelectedOptionId { get; set; }
    public bool? IsCorrect { get; set; } // Có thể được tính khi nộp bài

    // Navigation properties
    public QuizAttempt Attempt { get; set; } = null!;
    public QuizQuestion Question { get; set; } = null!;
    public QuizOption SelectedOption { get; set; } = null!;
}