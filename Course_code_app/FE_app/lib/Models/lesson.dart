class Lesson {
  final int id;
  final int? courseId;
  final String title;
  final String? contentSummary;
  final int? position;
  final String status; // 'Chưa học', 'Đang học', 'Đã hoàn thành'
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Lesson({
    required this.id,
    this.courseId,
    required this.title,
    this.contentSummary,
    this.position,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });
}