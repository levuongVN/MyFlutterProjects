import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_list/actions/tasks_action.dart';
import 'package:todo_list/modal/Tasks.dart';
import 'package:todo_list/state/app_state.dart';
import 'package:todo_list/widget/delete_task_widget.dart';
import 'package:todo_list/widget/modal_bottm_add_task.dart';
import 'package:todo_list/widget/task_items_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final randomId = Random();

  void _showTaskModal(BuildContext context, {Tasks? task}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return modal_bottom_add_task(
          nameTask: task?.name,
          text_Priority: task?.priority,
          handleSubmit: (value, priority) {
            final store = StoreProvider.of<AppState>(context);
            if (task == null) {
              store.dispatch(
                AddTaskAction(Tasks(randomId.nextInt(100), value, priority)),
              );
            } else {
              store.dispatch(
                EditTaskAction(task, Tasks(task.id, value, priority)),
              );
            }
          },
        );
      },
    );
  }

  void _deleteTaskModal(BuildContext context, Tasks task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return delete_task_widget(
          onDelete: () {
            final store = StoreProvider.of<AppState>(context);
            store.dispatch(DeleteTaskAction(task));
          },
        );
      },
    );
  }

  void _toggleFavorite(BuildContext context, Tasks task) {
    final store = StoreProvider.of<AppState>(context);
    Tasks updatedTask = Tasks(
      task.id,
      task.name,
      task.priority,
      isFavoutite: !task.isFavoutite,
    );
    store.dispatch(EditTaskAction(task, updatedTask));
    if (updatedTask.isFavoutite) {
      store.dispatch(AddTaskFavAction(updatedTask));
    } else {
      store.dispatch(RemoveTaskFavAction(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StoreConnector<AppState, List<Tasks>>(
        converter: (store) => store.state.tasks,
        builder: (context, tasks) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: tasks.map((task) {
                return TaskItem(
                  text: task.name,
                  textColor: Colors.white,
                  priority: task.priority,
                  isFavorite: task.isFavoutite,
                  fontSize: 20,
                  onDelete: () => _deleteTaskModal(context, task),
                  onEdit: () => _showTaskModal(context, task: task),
                  onToogleFav: () => _toggleFavorite(context, task),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskModal(context),
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
