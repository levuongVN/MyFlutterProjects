namespace Application.Responses;

public class LessonBlockResponse
{
    public int LessonId { get; set; }
    public object? Content { get; set; } // Quill Delta JSON
}
