import 'package:app_course_code/Models/lesson.dart';
import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final int? index;
  final VoidCallback onTap;

  const LessonCard({
    super.key,
    required this.lesson,
    this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = lesson.status == 'Đã hoàn thành';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Số thứ tự bài học, nếu học xong thì hiển thị dấu check
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.green[100] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: isCompleted
                    ? const Icon(Icons.check, size: 20, color: Colors.green)
                    : Text(
                        '$index',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
              ),
              const SizedBox(width: 16),

              // Thông tin bài học
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Icon loại bài học
                        const Icon(Icons.article, size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            lesson.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.contentSummary ?? '',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Nút play/continue
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  isCompleted ? Icons.replay : Icons.play_arrow,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


