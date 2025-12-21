import 'package:app_course_code/Models/lesson.dart';
import 'package:app_course_code/Models/lessonContent.dart';
import 'package:app_course_code/Services/Lesson/LessonServices.dart';
import 'package:flutter/foundation.dart';

class Viewmodellessons extends ChangeNotifier {
  final LessonServices lessonServices = LessonServices();

  List<Lesson> _lessons = [];
  List<Lessoncontent> _lessonContents = [];
  List<Lesson> get lessons => _lessons;
  List<Lessoncontent> get lessonContents => _lessonContents;
  bool isLoading = false;

  Future<void> fetchLessons() async {
    isLoading = true;
    notifyListeners();

    _lessons = await lessonServices.fetchLessons();

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchLessonsContents() async {
    isLoading = true;
    notifyListeners();
    _lessonContents = await lessonServices.fetchLessonsContents();
    isLoading = false;
    notifyListeners();
  }
}
