import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:todo_list/reducers/tasks_reducer.dart';
import 'package:todo_list/state/app_state.dart';

import 'package:todo_list/utils/profile_method.dart';
import 'package:todo_list/widget/fav_task_widget.dart';
import 'package:todo_list/widget/login.dart';
import 'package:todo_list/widget/search.dart';
import 'package:todo_list/widget/home.dart';

void main() {
  final store = Store<AppState>(
    taskReducer,
    initialState: AppState.initialState(),
  );

  runApp(
    StoreProvider<AppState>(
      store: store,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainLayout(),
      ),
    ),
  );
}

/// Layout cha có bottom navigation
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(), // Home tách riêng
    SearchTaskPage(),
    FavoritesPage(),
    Center(child: Text("Categories Page")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          _selectedIndex == 0
              ? "Todolist"
              : _selectedIndex == 1
              ? "Search Tasks"
              : _selectedIndex == 2
              ? "Favorites"
              : "Categories",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: "customFont",
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: profileMethod(),
          ),
        ],
        backgroundColor: Colors.cyan,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Fav'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
      ),
    );
  }
}
