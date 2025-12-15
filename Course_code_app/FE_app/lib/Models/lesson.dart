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
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      contentSummary: json['contentSummary'],
      position: json['position'],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}