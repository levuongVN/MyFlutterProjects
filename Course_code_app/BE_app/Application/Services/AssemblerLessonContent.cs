using Application.DTOs;
using Application.Responses;
using System.Text.Json;

public class LessonDeltaAssembler
{
    public LessonBlockResponse Build(List<LessonBlockDto> blocks)
    {
        var ops = new List<Dictionary<string, object>>();

        foreach (var block in blocks.OrderBy(b => b.SortOrder))
        {
            var json = JsonSerializer.Deserialize<JsonElement>(block.Content);

            switch (block.BlockType)
            {
                case "text":
                    ops.Add(new Dictionary<string, object>
                    {
                        ["insert"] = json.GetProperty("text").GetString() + "\n"
                    });
                    break;
                case "image":
                    ops.Add(new Dictionary<string, object>
                    {
                        ["insert"] = new Dictionary<string, object>
                        {
                            ["image"] = json.GetProperty("url").GetString()
                        }
                    });
                    ops.Add(new Dictionary<string, object> { ["insert"] = "\n" });
                    break;

                case "code":
                    ops.Add(new Dictionary<string, object>
                    {
                        ["insert"] = json.GetProperty("code").GetString() + "\n",
                        ["attributes"] = new Dictionary<string, object>
                        {
                            ["code-block"] = true
                        }
                    });
                    ops.Add(new Dictionary<string, object> { ["insert"] = "\n" });
                    break;

                case "video":
                    ops.Add(new Dictionary<string, object>
                    {
                        ["insert"] = json.GetProperty("title").GetString() + "\n",
                        ["attributes"] = new Dictionary<string, object>
                        {
                            ["link"] = json.GetProperty("url").GetString()
                        }
                    });
                    break;
            }
        }

        return new LessonBlockResponse
        {
            LessonId = blocks.First().LessonId ?? 0,
            Content = new Dictionary<string, object>
            {
                ["ops"] = ops
            }
        };
    }
}
