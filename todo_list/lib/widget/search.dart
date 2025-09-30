import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_list/modal/Tasks.dart';
import 'package:todo_list/state/app_state.dart';

class SearchTaskPage extends StatefulWidget {
  const SearchTaskPage({super.key});

  @override
  State<SearchTaskPage> createState() => _SearchTaskPageState();
}

class _SearchTaskPageState extends State<SearchTaskPage> {
  String _searchText = "";
  String? _selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Tasks"),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search by task name...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: _selectedPriority,
              decoration: const InputDecoration(
                labelText: "Filter by priority",
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text("All")),
                const DropdownMenuItem(value: "High", child: Text("High")),
                const DropdownMenuItem(value: "Medium", child: Text("Medium")),
                const DropdownMenuItem(value: "Low", child: Text("Low")),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value;
                });
              },
            ),
          ),

          // Hiển thị danh sách
          Expanded(
            child: StoreConnector<AppState, List<Tasks>>(
              converter: (store) => store.state.tasks,
              builder: (context, tasks) {
                final filteredTasks = tasks.where((task) {
                  final matchesName = task.name.toLowerCase().contains(
                    _searchText,
                  );
                  final matchesPriority =
                      _selectedPriority == null || task.priority == _selectedPriority;
                  return matchesName && matchesPriority;
                }).toList();

                if (filteredTasks.isEmpty) {
                  return const Center(child: Text("No tasks found"));
                }
                return ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    Color priorityColor;
                    switch (task.priority) {
                      case "High":
                        priorityColor = Colors.red;
                        break;
                      case "Medium":
                        priorityColor = Colors.orange;
                        break;
                      case "Low":
                        priorityColor = Colors.green;
                        break;
                      default:
                        priorityColor = Colors.grey;
                    }
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: ListTile(
                        title: Text(
                          task.name,
                          style: TextStyle(
                            color: priorityColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text("Priority: ${task.priority}"),
                        leading: Icon(Icons.task_alt, color: priorityColor),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
