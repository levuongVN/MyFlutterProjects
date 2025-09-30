import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_list/state/app_state.dart';
import 'package:todo_list/modal/Tasks.dart';
import 'package:todo_list/widget/task_items_widget.dart';
import 'package:todo_list/actions/tasks_action.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Tasks"),
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.white,
      body: StoreConnector<AppState, List<Tasks>>(
        converter: (store) => store.state.taskFav,
        builder: (context, favoriteTasks) {
          print(favoriteTasks);
          if (favoriteTasks.isEmpty) {
            return const Center(
              child: Text(
                "Nothings task is favorited",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: favoriteTasks.length,
            itemBuilder: (context, index) {
              final task = favoriteTasks[index];
              return TaskItem(
                text: task.name,
                textColor: Colors.white,
                priority: task.priority,
                isFavorite: task.isFavoutite,
                fontSize: 20,
                onDelete: () {},
                onEdit: () {},
                onToogleFav: () {
                  final store = StoreProvider.of<AppState>(context);
                  store.dispatch(RemoveTaskFavAction(task));
                },
              );
            },
          );
        },
      ),
    );
  }
}
