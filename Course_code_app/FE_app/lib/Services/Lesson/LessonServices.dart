import 'dart:convert';
import 'package:app_course_code/Models/lesson.dart';
import 'package:app_course_code/config/baseURL.dart';
import 'package:http/http.dart' as http;

class LessonServices {
  Future<List<Lesson>> fetchLessons() async {
    final response = await http.get(Uri.parse('${BaseUrl.api}/api/Lesson/Lessons'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonItem) => Lesson.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load lessons');
    }
  }
}