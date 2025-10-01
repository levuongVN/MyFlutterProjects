namespace backend.Models;

public class Language
{
    public int Id { get; set; }
    public string LanguageName { get; set; } = string.Empty; // Đổi tên từ 'language' để rõ nghĩa hơn

    // Navigation properties
    public ICollection<Course> Courses { get; set; } = new List<Course>();
}