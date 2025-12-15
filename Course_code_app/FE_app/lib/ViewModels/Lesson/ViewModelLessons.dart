import 'package:app_course_code/Models/lesson.dart';
import 'package:app_course_code/Services/Lesson/LessonServices.dart';
import 'package:flutter/foundation.dart';

class Viewmodellessons extends ChangeNotifier {
  final LessonServices lessonServices = LessonServices();

  List<Lesson> lessons = [];
  bool isLoading = false;

  Future<void> fetchLessons() async {
    isLoading = true;
    notifyListeners();

    lessons = await lessonServices.fetchLessons();
    
    isLoading = false;
    notifyListeners();
  }
}
