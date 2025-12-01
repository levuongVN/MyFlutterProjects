import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                Text('Hi userNameHere ', style: TextStyle(color: Colors.black)),
                Icon(Icons.waving_hand, color: Colors.amber),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blue[800],
        toolbarHeight: 100.5,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior
            .onlyShowSelected, // <- chỉ show label tab đang chọn
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          NavigationDestination(icon: Icon(Icons.smart_toy), label: 'Chatbot'),
          NavigationDestination(icon: Icon(Icons.book), label: 'My Courses'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: <Widget>[
        // 1️⃣ Home
        Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Text('Home Page', style: theme.textTheme.headlineMedium),
              ),
            ),
          ),
        ),

        // 2️⃣ Notifications
        ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notification 1'),
                subtitle: Text('This is a notification.'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notification 2'),
                subtitle: Text('This is a notification.'),
              ),
            ),
          ],
        ),

        // 3️⃣ Chatbot
        Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Chatbot Page',
                  style: theme.textTheme.headlineMedium,
                ),
              ),
            ),
          ),
        ),

        // 4️⃣ My Courses
        ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text('Course 1'),
                subtitle: Text('In Progress'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text('Course 2'),
                subtitle: Text('Completed'),
              ),
            ),
          ],
        ),

        // 5️⃣ Profile
        Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Profile Page',
                  style: theme.textTheme.headlineMedium,
                ),
              ),
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}
