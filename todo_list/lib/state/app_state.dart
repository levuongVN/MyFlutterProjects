import '../modal/Tasks.dart';

class AppState {
  final List<Tasks> tasks;
  final List<Tasks> taskFav;
  AppState({required this.tasks, required this.taskFav});
  AppState.initialState() : tasks = [], taskFav = [];
}
