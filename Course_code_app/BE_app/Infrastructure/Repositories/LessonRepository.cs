using Infrastructure.Data;
using Core.Entities;
using Microsoft.EntityFrameworkCore;

public class LessonRepository : ILessonRepository
{
    private readonly ApplicationDbContext _context;
    public LessonRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<List<LessonBlock>> GetLessonBlockAsync()
    {
        var blocks = await _context.LessonBlocks
                    .Where(b => b.LessonId == 2)
                    .OrderBy(b => b.SortOrder) // Sắp xếp theo thứ tự
                    .Include(b => b.Lesson)
                    .ToListAsync();

        return blocks;
    }

    public async Task<List<Lesson>> GetLessonsAsync()
    {
        var lessons = await _context.Lessons
                    .Where(l => l.Id == 2)
                    .OrderBy(l => l.Position)
                    .ToListAsync();
        return lessons;
    }
}