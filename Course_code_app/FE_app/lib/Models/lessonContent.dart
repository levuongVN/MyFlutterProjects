import 'package:app_course_code/Models/lesson.dart';

class Lessoncontent {
   final int lessonId;
  final List<dynamic> ops;

  Lessoncontent({
    required this.lessonId,
    required this.ops,

  });
  factory Lessoncontent.fromJson(Map<String, dynamic> json) {
    return Lessoncontent(
      lessonId: json['lessonId'],
      ops: json['content']['ops'],
    );
  }
}