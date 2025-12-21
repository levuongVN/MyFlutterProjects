import 'package:app_course_code/Models/lesson.dart';
import 'package:app_course_code/ViewModels/Lesson/ViewModelLessons.dart';
import 'package:app_course_code/Views/Cards/lesson_card.dart';
import 'package:app_course_code/Views/Lesson/LessonContents.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseTitle;
  final String courseDescription;
  final String instructor;
  final double progress;

  const CourseDetailScreen({
    super.key,
    required this.courseTitle,
    required this.courseDescription,
    required this.instructor,
    this.progress = 1.0,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<Viewmodellessons>();
    final lessons = viewModel.lessons;
    final isLoading = viewModel.isLoading;

    final completedLessons = lessons
        .where((l) => l.status == 'Đã hoàn thành')
        .length;
    final totalLessons = lessons.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.courseTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.share), onPressed: () {})],
      ),
      body: Column(
        children: [
          // Header với thông tin khóa học
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.courseTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.courseDescription,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue[100],
                      child: const Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.instructor,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Progress bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tiến độ: ${(widget.progress * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$completedLessons/$totalLessons bài học',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: widget.progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Danh sách bài học
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      return LessonCard(
                        lesson: lesson,
                        index: lesson.position,
                        onTap: () => _handleLessonTap(lesson),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _handleLessonTap(Lesson lesson) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => Viewmodellessons()..fetchLessonsContents(),
          child: const Lessoncontents(),
        ),
      ),
    );
  }
}