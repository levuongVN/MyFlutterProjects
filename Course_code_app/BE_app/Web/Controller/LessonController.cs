using Application.DTOs;
using Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

[ApiController]
[Route("api/[controller]")]
public class LessonController : ControllerBase
{
    private readonly IlessonServices _lessonService;

    public LessonController(IlessonServices lessonService)
    {
        _lessonService = lessonService;
    }
    
    [HttpGet]
    [Route("Lessons")]
    public async Task<ActionResult<List<LessonDto>>> GetLessons()
    {
        try
        {
            var lessons = await _lessonService.GetLessonsAsync();

            if (lessons == null || !lessons.Any())
                return NoContent();

            return Ok(lessons);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new
            {
                message = "Lỗi khi lấy dữ liệu bài học",
                detail = ex.Message
            });
        }
    }

    [HttpGet]
    [Route("LessonContent")]
    public async Task<ActionResult<List<LessonBlockDto>>> GetLessonBlock()
    {
        try
        {
            var lessons = await _lessonService.GetLessonsAsync();

            if (lessons == null || !lessons.Any())
                return NoContent();

            return Ok(lessons);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new
            {
                message = "Lỗi khi lấy dữ liệu bài học",
                detail = ex.Message
            });
        }
    }
}
