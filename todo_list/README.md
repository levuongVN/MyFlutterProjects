<!-- 
import 'students.dart'; // import class here
void main(List<String> args) {
  // String helloWorld = 'hello world!';
  // dynamic allType = 1; // this type can acp every type of data and its value if you dont initial values this type auto be null
  // allType = 'Vuong';
  // allType = false;

  // List<dynamic> listStudents = [
  //   'Vuong',
  //   'Duy Tien',
  //   'Duc Anh',
  // ]; // its like the array
  // Map<dynamic, dynamic> objStudents = {
  //   'Ma sv': 001,
  //   'Ten Sinh Vien': 'LeVuong',
  // };
  var students = Students('Vuong', 18);
  // print('This is name of: ${students.getName}'); // call the getter
  // students.setName = 'LeVuongChanged'; // call the setter

  var goodStudent = GoodStudent('Vuongdz', 20, 8.8);
  goodStudent.displayNameOfGoodStudent();
  // print(helloWorld);
  // print(allType);
  // print(listStudents[1]);
  // print(objStudents['Ten Sinh Vien']);
} -->

<!-- import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // main function to run app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    containerMethod('box 1!', Alignment.bottomRight, false),
                    containerMethod('box 2!', Alignment.bottomLeft, false),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    containerMethod('box 3!', Alignment.topRight, false),
                    containerMethod('box 4!', Alignment.topLeft, false),
                  ],
                ),
              ],
            ),
            Center(child: containerMethod('Center!', Alignment.center, true)), // hình tròn
          ],
        ),
      ),
    );
  }

  Container containerMethod(String text, Alignment alignment, bool isCircle) {
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
      width: 150,
      height: 150,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
} -->

<!--  ĐÂY LÀ KHÁI NIỆM STATE FULL-LESS THEO TIẾNG VIỆT
StatelessWidget là một loại widget trong Flutter không có trạng thái bên trong — nghĩa là:
- Nó chỉ hiển thị UI dựa trên dữ liệu được truyền vào qua constructor.
- Không tự thay đổi sau khi đã build, trừ khi dữ liệu từ bên ngoài thay đổi và widget được build lại từ đầu.

StatefulWidget là gì?
- Là widget có trạng thái bên trong.
- Trạng thái (state) này có thể thay đổi trong quá trình app chạy mà không cần tạo lại widget từ đầu.
- Khi state thay đổi → bạn gọi setState() → Flutter rebuild lại UI của widget đó.
 -->


 <!-- Stream!!!
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Hàm main chạy app Flutter, gắn root widget là MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: widget gốc, cung cấp theme + navigation
    return const MaterialApp(home: StreamExample());
  }
}

class StreamExample extends StatefulWidget {
  const StreamExample({super.key});

  @override
  State<StreamExample> createState() => _StreamExampleState();
  /*
    👉 StatefulWidget: widget có state (dữ liệu thay đổi được).
    - createState() trả về một object State (ở đây là _StreamExampleState).
    - Generic <StreamExample> có nghĩa: State này được "gắn" cho StreamExample,
      để Flutter biết State nào thuộc về Widget nào.
  */
}

class _StreamExampleState extends State<StreamExample> {
  late Stream<int> timerStream; 
  /*
    👉 Biến timerStream:
    - Đây là Stream<int>, tức là một dòng chảy dữ liệu mà mỗi "sự kiện" phát ra
      sẽ là một số nguyên.
    - Mình sẽ gán nó trong initState().
  */

  @override
  void initState() {
    super.initState();

    // Stream.periodic: cứ sau mỗi duration thì phát ra một sự kiện mới
    timerStream = Stream<int>.periodic(
      const Duration(seconds: 1), // phát mỗi 1 giây
      (int count) {
        /*
          Hàm callback này nhận vào một biến đếm (count) tự động tăng
          bắt đầu từ 0 → 1 → 2 → ...
          → Mỗi lần gọi, mình return count + 1 để chuỗi trở thành 1,2,3...
        */
        return count + 1;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ví dụ về Stream")),
      body: Center(
        // StreamBuilder: widget đặc biệt để "nghe" stream và rebuild UI khi có dữ liệu mới
        child: StreamBuilder<int>(
          stream: timerStream, // stream mà nó lắng nghe
          builder: (context, snapshot) {
            /*
              👉 builder: được gọi lại mỗi khi stream phát ra một giá trị mới.
              - snapshot là ảnh chụp trạng thái hiện tại của stream:
                + snapshot.data     → dữ liệu mới nhất
                + snapshot.hasData  → true nếu có dữ liệu
                + snapshot.hasError → true nếu có lỗi
                + snapshot.error    → thông tin lỗi
                + snapshot.connectionState → trạng thái stream:
                   - waiting: chưa có dữ liệu đầu tiên
                   - active: đang phát dữ liệu
                   - done: stream đã kết thúc
            */

            if (snapshot.connectionState == ConnectionState.waiting) {
              // Khi stream vừa bắt đầu kết nối, chưa có dữ liệu đầu tiên
              return const Text("Đang chờ dữ liệu...");
            } else if (snapshot.hasError) {
              // Nếu stream bắn ra lỗi
              return Text("Lỗi: ${snapshot.error}");
            } else if (snapshot.hasData) {
              // Nếu có dữ liệu mới → hiển thị
              return Text(
                "Đếm: ${snapshot.data}",
                style: const TextStyle(fontSize: 30),
              );
            } else {
              // Trường hợp khác (vd: stream đã kết thúc nhưng không có data)
              return const Text("Không có dữ liệu");
            }
          },
        ),
      ),
    );
  }
}
  -->


<!-- 
ĐÂY LÀ PHẦN PROVIDERS
import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

// import 'package:http/http.dart';
import 'package:todo_list/config/graphql_config.dart';
import 'package:todo_list/modal/Tasks.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/reducers/tasks_reducer.dart';
// import 'package:todo_list/models/album.dart';
// import 'package:todo_list/services/album_service.dart';
import 'package:todo_list/widget/delete_task_widget.dart';
import 'package:todo_list/widget/modal_bottm_add_task.dart';
import 'widget/Task_Items_widget.dart';
import 'package:todo_list/utils/profile_method.dart';
import 'package:todo_list/widget/login.dart';

void main() {
  final client = GraphQLConfig.initClient();
  runApp(
    GraphQLProvider(
      client: client,
      child: ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MyAppState(); // return another class to use the state
  } // make the state
}

// this class has the UI/Logic here
class _MyAppState extends State<MyApp> {
  final randomId = Random();
  Tasks? _currentEditingTask; // the task is editing
  // bool _isFetched = false; // this flag var to ensure just fetch api one time!

  // Future<void> _fetchAlbum() async {
  //   final client = GraphQLProvider.of(context).value;
  //   final albumService = AlbumGraphQLService(client);

  //   final title = await albumService.fetchAlbumTitle(1);
  //   print("Album title (GraphQL): $title");
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!_isFetched) {
  //     _fetchAlbum();
  //     _isFetched = true;
  //   }
  // }

  void _addTask(String name, String priority) {
    final newTask = Tasks(randomId.nextInt(100), name, priority);
    // print(newTask);
    context.read<TaskProvider>().addTask(newTask);
  }

  void _editTask(String name, String priority) {
    if (_currentEditingTask != null) {
      final updatedTask = Tasks(
        _currentEditingTask!.id, // giữ nguyên id cũ
        name,
        priority,
      );
      context.read<TaskProvider>().editTask(_currentEditingTask!, updatedTask);
    }
  }

  void _deleteTask(Tasks task) {
    context.read<TaskProvider>().deleteTask(task);
  }

  void _deleteTaskModal(Tasks task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return delete_task_widget(
          onDelete: () {
            _deleteTask(task);
          },
        );
      },
    );
  }

  void _showTaskModal({Tasks? task}) {
    // this function to display the widget and confortable for performace between the edit and add task
    _currentEditingTask =
        task; // ref the data in list and the data will be changed
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return modal_bottom_add_task(
          nameTask: task?.name,
          text_Priority: task?.priority,
          handleSubmit: (value, priority) {
            if (task == null) {
              _addTask(value, priority);
            } else {
              _editTask(value, priority);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Todolist',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ...taskProvider.tasks.map((task) {
              return TaskItem(
                text: task.name,
                textColor: Colors.white,
                priority: task.priority,
                fontSize: 20,
                onDelete: () {
                  _deleteTaskModal(task);
                },
                onEdit: () {
                  _showTaskModal(task: task);
                },
              );
            }), // must return a list to access with type of children
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskModal();
        },
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
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

-->