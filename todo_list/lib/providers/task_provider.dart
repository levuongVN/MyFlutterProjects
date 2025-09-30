import 'package:flutter/material.dart';
import 'package:todo_list/modal/Tasks.dart';

class TaskProvider extends ChangeNotifier {
  List<Tasks> tasks = [];

  void addTask(Tasks task) {
    tasks.add(task);
    notifyListeners(); // báo cho UI update
  }

  void deleteTask(Tasks task) {
    tasks.remove(task);
    notifyListeners();
  }

  void editTask(Tasks oldTask, Tasks newTask) {
    final index = tasks.indexOf(oldTask);
    if (index != -1) {
      tasks[index] = newTask;
      notifyListeners();
    }
  }
}
