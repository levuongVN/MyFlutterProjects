
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Enum định nghĩa các hành động có thể thực hiện với task
enum TaskAction { toggleDone, fav, edit, delete }

class TaskItem extends StatefulWidget {
  final String text;
  final String? priority;
  final Color textColor;
  final bool isFavorite;
  final double fontSize;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onToogleFav;

  const TaskItem({
    super.key,
    required this.text,
    this.textColor = const Color.fromARGB(255, 25, 25, 25),
    this.fontSize = 16,
    required this.isFavorite,
    required this.onDelete,
    required this.onEdit,
    required this.onToogleFav,
    this.priority,
  });

  @override
  State<TaskItem> createState() => _TaskItemsState();
}

class _TaskItemsState extends State<TaskItem> {
  bool _isDone = false;

  void _handleMenuAction(TaskAction action) {
    // nhận vào action tương ứng để thực hiện nv cụ thể
    switch (action) {
      case TaskAction.toggleDone:
        setState(() => _isDone = !_isDone);
        break;
      case TaskAction.edit:
        if (!_isDone) widget.onEdit();
        break;
      case TaskAction.fav:
        if (!_isDone) {
          widget.onToogleFav();
        }
        break;
      case TaskAction.delete:
        if (!_isDone) widget.onDelete();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isDone = !_isDone),
      child: AnimatedContainer(
        margin: const EdgeInsets.only(bottom: 12),
        duration: 300.ms,
        width: double.infinity,
        height: 74,
        decoration: BoxDecoration(
          color: _isDone
              ? Colors.blueGrey
              : widget.priority == 'Low'
              ? Colors.green
              : widget.priority == 'Medium'
              ? Colors.orange
              : widget.priority == "High"
              ? Colors.redAccent
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: _isDone
                          ? const Color.fromARGB(173, 158, 158, 158)
                          : widget.textColor,
                      fontSize: widget.fontSize,
                      decoration: _isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_isDone)
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: 300.ms,
                      builder: (_, value, __) => Container(
                        height: 1,
                        width: value * MediaQuery.of(context).size.width,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            PopupMenuButton<TaskAction>(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onSelected:
                  _handleMenuAction, // hàm này để gọi đến các tác vụ cho từng action trong list
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<TaskAction>>[
                    PopupMenuItem<TaskAction>(
                      value: TaskAction.toggleDone,
                      child: Row(
                        children: [
                          Icon(_isDone ? Icons.refresh : Icons.done_all),
                          const SizedBox(width: 8),
                          Text(
                            _isDone ? 'Đánh dấu chưa hoàn thành' : 'Hoàn thành',
                          ),
                        ],
                      ),
                    ),
                    if (!_isDone) ...[
                      const PopupMenuDivider(),
                      PopupMenuItem<TaskAction>(
                        value: TaskAction.edit,
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            const SizedBox(width: 8),
                            Text('Chỉnh sửa'),
                          ],
                        ),
                      ),
                      PopupMenuItem<TaskAction>(
                        value: TaskAction.delete,
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            const SizedBox(width: 8),
                            Text('Xóa', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      PopupMenuItem<TaskAction>(
                        value: TaskAction
                            .fav, // Cần thêm giá trị này vào enum TaskAction
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: widget.isFavorite
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.isFavorite ? 'Bỏ yêu thích' : 'Yêu thích',
                              style: TextStyle(
                                color: widget.isFavorite
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
            ),
          ],
        ),
      ),
    );
  }
}
