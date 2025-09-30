import '../modal/Tasks.dart';

class AddTaskAction {
  final Tasks task;
  AddTaskAction(this.task);
}

class EditTaskAction {
  final Tasks oldTask;
  final Tasks newTask;
  EditTaskAction(this.oldTask, this.newTask);
}

class DeleteTaskAction {
  final Tasks task;
  DeleteTaskAction(this.task);
}

// ==== Actions for Favorite Tasks  ====
class AddTaskFavAction {
  final Tasks task;
  AddTaskFavAction(this.task);
}

class RemoveTaskFavAction {
  final Tasks task;
  RemoveTaskFavAction(this.task);
}

class UnfavTaskAction {
  final Tasks task;
  UnfavTaskAction(this.task);
}
