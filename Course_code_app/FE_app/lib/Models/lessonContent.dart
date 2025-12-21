import 'package:app_course_code/Models/lesson.dart';

class Lessoncontent {
  final int id;
  final int lessonId;
  final String blockType;
  final int sortOrder;
  final String content;
  final String? metaData;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Lesson? lesson;
  Lessoncontent({
    required this.id,
    required this.lessonId,
    required this.blockType,
    required this.sortOrder,
    required this.content,
    this.metaData,
    this.createdAt,
    this.updatedAt,
    this.lesson,
  });
  factory Lessoncontent.fromJson(Map<String, dynamic> json) {
    return Lessoncontent(
      id: json['id'],
      lessonId: json['lessonId'],
      blockType: json['blockType'],
      sortOrder: json['sortOrder'],
      content: json['content'],
      metaData: json['metaData'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      lesson: json['lesson'] != null
          ? Lesson.fromJson(json['lesson'])
          : null,
    );
  }
}