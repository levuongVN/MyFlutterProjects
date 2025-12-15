using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Core.Entities;

namespace Core.Entities
{
    [Table("lesson_blocks")]
    public class LessonBlock
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }

        [Column("block_type")]
        [Required]
        [MaxLength(50)]
        public string BlockType { get; set; }

        [Column("sort_order")]
        public int SortOrder { get; set; }

        [Column("content_json")]
        public string ContentJson { get; set; }

        [Column("metadata_json")]
        public string? MetadataJson { get; set; }

        [Column("created_at")]
        public DateTime CreatedAt { get; set; }

        [Column("updated_at")]
        public DateTime? UpdatedAt { get; set; }
        [Column("lesson_id")]
        public int LessonId { get; set; }
        public Lesson? Lesson { get; set; }
    }
}