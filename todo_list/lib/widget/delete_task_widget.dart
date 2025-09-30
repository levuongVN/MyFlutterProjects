import 'package:flutter/material.dart';

class delete_task_widget extends StatelessWidget {
  final VoidCallback onDelete;
  const delete_task_widget({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are You want to delete this task?'),
      content: Text(
        'This action cannot be undone.',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel', style: TextStyle(fontSize: 18)),
        ),
        TextButton(
          onPressed: () {
            onDelete(); // call the function
            Navigator.of(context).pop();
          },
          child: Text('Sure!', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
