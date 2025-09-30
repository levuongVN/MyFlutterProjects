import 'package:todo_list/actions/tasks_action.dart';
import 'package:todo_list/state/app_state.dart';
import 'package:todo_list/modal/Tasks.dart';

AppState taskReducer(AppState state, dynamic action) {
  if (action is AddTaskAction) {
    return AppState(
      tasks: [...state.tasks, action.task],
      taskFav: state.taskFav,
    );
  } else if (action is EditTaskAction) {
    final updatedTasks = state.tasks.map((task) {
      return task.id == action.oldTask.id ? action.newTask : task;
    }).toList();
    final updatedFav = state.taskFav.map((task) {
      return task.id == action.oldTask.id ? action.newTask : task;
    }).toList();

    return AppState(tasks: updatedTasks, taskFav: updatedFav);
  } else if (action is DeleteTaskAction) {
    return AppState(
      tasks: state.tasks.where((task) => task.id != action.task.id).toList(),
      taskFav: state.taskFav
          .where((task) => task.id != action.task.id)
          .toList(),
    );
  } else if (action is AddTaskFavAction) {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == action.task.id) {
        return Tasks(task.id, task.name, task.priority, isFavoutite: true);
      }
      return task;
    }).toList();

    return AppState(
      tasks: updatedTasks,
      taskFav: [...state.taskFav, action.task],
    );
  } else if (action is RemoveTaskFavAction) {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == action.task.id) {
        return Tasks(task.id, task.name, task.priority, isFavoutite: false);
      }
      return task;
    }).toList();
    return AppState(
      tasks: updatedTasks,
      taskFav: state.taskFav.where((t) => t.id != action.task.id).toList(),
    );
  }

  return state;
}
