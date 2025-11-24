using Microsoft.EntityFrameworkCore;
using Core.Entities;

namespace Infrastructure.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    // DbSets
    public DbSet<Role> Roles { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<Language> Languages { get; set; }
    public DbSet<Course> Courses { get; set; }
    public DbSet<Enrollment> Enrollments { get; set; }
    public DbSet<Lesson> Lessons { get; set; }
    public DbSet<Quiz> Quizzes { get; set; }
    public DbSet<QuizQuestion> QuizQuestions { get; set; }
    public DbSet<QuizOption> QuizOptions { get; set; }
    public DbSet<QuizAttempt> QuizAttempts { get; set; }
    public DbSet<UserAnswer> UserAnswers { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // User configurations
        modelBuilder.Entity<User>()
            .HasIndex(u => u.Email)
            .IsUnique();

        // Role configurations
        modelBuilder.Entity<Role>()
            .HasIndex(r => r.Name)
            .IsUnique();

        // Course configurations
        modelBuilder.Entity<Course>()
            .Property(c => c.Status)
            .HasDefaultValue("draft");

        // Enrollment configurations
        modelBuilder.Entity<Enrollment>()
            .Property(e => e.Progress)
            .HasDefaultValue(0);

        modelBuilder.Entity<Enrollment>()
            .Property(e => e.Status)
            .HasDefaultValue("in_progress");

        // Lesson configurations
        modelBuilder.Entity<Lesson>()
            .Property(l => l.Status)
            .HasDefaultValue("Chưa học");

        // Quiz configurations
        modelBuilder.Entity<Quiz>()
            .HasIndex(q => q.LessonId)
            .IsUnique()
            .HasFilter("[LessonId] IS NOT NULL");

        // QuizQuestion configurations
        modelBuilder.Entity<QuizQuestion>()
            .Property(q => q.QuestionType)
            .HasDefaultValue("multiple_choice");

        modelBuilder.Entity<QuizQuestion>()
            .Property(q => q.Points)
            .HasDefaultValue(0);

        // ========== CONFIGURE ALL RELATIONSHIPS ==========

        // User -> Role (Many to One)
        modelBuilder.Entity<User>()
            .HasOne(u => u.Role)
            .WithMany(r => r.Users)
            .HasForeignKey(u => u.RoleId)
            .OnDelete(DeleteBehavior.Restrict);

        // Course -> Language (Many to One)
        modelBuilder.Entity<Course>()
            .HasOne(c => c.Language) // một thực thể course sẽ có một ngôn ngữ code (Language)
            .WithMany(l => l.Courses) // Chỉ rằng thưucj thể Language sẽ có nhiều bản ghi cho courses
            .HasForeignKey(c => c.LanguageId) // Chỉ đinh khoá ngoại
            .OnDelete(DeleteBehavior.Restrict); // kiểm soát hành vi xoá, khi xoá các bảng mà data nó liên quan đến các bảng khác sẽ báo lỗi.

        // Course -> User (Many to One) - Creator
        modelBuilder.Entity<Course>()
            .HasOne(c => c.Creator)
            .WithMany(u => u.CreatedCourses)
            .HasForeignKey(c => c.CreatedBy)
            .OnDelete(DeleteBehavior.Restrict);

        // Enrollment -> User (Many to One)
        modelBuilder.Entity<Enrollment>()
            .HasOne(e => e.User)
            .WithMany(u => u.Enrollments)
            .HasForeignKey(e => e.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        // Enrollment -> Course (Many to One)
        modelBuilder.Entity<Enrollment>()
            .HasOne(e => e.Course)
            .WithMany(c => c.Enrollments)
            .HasForeignKey(e => e.CourseId)
            .OnDelete(DeleteBehavior.Restrict);

        // Lesson -> Course (Many to One)
        modelBuilder.Entity<Lesson>()
            .HasOne(l => l.Course)
            .WithMany(c => c.Lessons)
            .HasForeignKey(l => l.CourseId)
            .OnDelete(DeleteBehavior.Restrict);

        // Quiz -> Lesson (One to One) - Optional
        modelBuilder.Entity<Quiz>()
            .HasOne(q => q.Lesson)
            .WithOne(l => l.Quiz)
            .HasForeignKey<Quiz>(q => q.LessonId)
            .OnDelete(DeleteBehavior.Restrict);

        // QuizQuestion -> Quiz (Many to One)
        modelBuilder.Entity<QuizQuestion>()
            .HasOne(q => q.Quiz)
            .WithMany(qz => qz.Questions)
            .HasForeignKey(q => q.QuizId)
            .OnDelete(DeleteBehavior.Cascade);

        // QuizOption -> QuizQuestion (Many to One)
        modelBuilder.Entity<QuizOption>()
            .HasOne(o => o.Question)
            .WithMany(q => q.Options)
            .HasForeignKey(o => o.QuestionId)
            .OnDelete(DeleteBehavior.Cascade);

        // QuizAttempt -> User (Many to One)
        modelBuilder.Entity<QuizAttempt>()
            .HasOne(a => a.User)
            .WithMany(u => u.QuizAttempts)
            .HasForeignKey(a => a.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        // QuizAttempt -> Quiz (Many to One)
        modelBuilder.Entity<QuizAttempt>()
            .HasOne(a => a.Quiz)
            .WithMany(q => q.QuizAttempts)
            .HasForeignKey(a => a.QuizId)
            .OnDelete(DeleteBehavior.Restrict);

        // UserAnswer -> QuizAttempt (Many to One)
        modelBuilder.Entity<UserAnswer>()
            .HasOne(a => a.Attempt)
            .WithMany(at => at.UserAnswers)
            .HasForeignKey(a => a.AttemptId)
            .OnDelete(DeleteBehavior.Cascade);

        // UserAnswer -> QuizQuestion (Many to One)
        modelBuilder.Entity<UserAnswer>()
            .HasOne(a => a.Question)
            .WithMany(q => q.UserAnswers)
            .HasForeignKey(a => a.QuestionId)
            .OnDelete(DeleteBehavior.Restrict);

        // UserAnswer -> QuizOption (Many to One) - Optional
        modelBuilder.Entity<UserAnswer>()
            .HasOne(a => a.SelectedOption)
            .WithMany(o => o.UserAnswers)
            .HasForeignKey(a => a.SelectedOptionId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}