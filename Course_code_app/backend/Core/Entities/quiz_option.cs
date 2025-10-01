namespace backend.Models;

public class QuizOption
{
    public int Id { get; set; }
    public int QuestionId { get; set; }
    public string OptionText { get; set; } = string.Empty;
    public bool? IsCorrect { get; set; } // null nếu không phải là câu trả lời đúng

    // Navigation properties
    public QuizQuestion Question { get; set; } = null!;
    public ICollection<UserAnswer> UserAnswers { get; set; } = new List<UserAnswer>();
}