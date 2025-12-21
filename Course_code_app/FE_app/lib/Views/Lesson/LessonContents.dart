import 'package:app_course_code/ViewModels/Lesson/ViewModelLessons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lessoncontents extends StatefulWidget {
  const Lessoncontents({super.key});

  @override
  State<Lessoncontents> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Lessoncontents> {
  @override
  Widget build(BuildContext context) {
    final viewModels = context.watch<Viewmodellessons>();
    final lessonContents = viewModels.lessonContents;
    final isLoading = viewModels.isLoading;
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lessonContents.length,
              itemBuilder: (context, index) {
                final lessonContent = lessonContents[index];
                return Text(lessonContent.content);
              },
            ),
    );
  }
}