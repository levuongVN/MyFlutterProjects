namespace Core.Entities;

public class Language
{
    public int Id { get; set; }
    public string LanguageName { get; set; } = string.Empty;
    
    // Navigation properties
    public ICollection<Course> Courses { get; set; } = new List<Course>();
}