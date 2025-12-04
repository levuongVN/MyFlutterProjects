import 'package:app_course_code/Services/Authentication/Auth.dart';
import 'package:app_course_code/Views/Index.dart';
import 'package:app_course_code/Views/Login/Login.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Thêm binding này để tạo cầu nối giữa engine và widget UI. (Nếu muốn dùng các engine như awai, fire base,... Trước khi run app)
  WidgetsFlutterBinding.ensureInitialized();
  final (isLogged, isExpired) = await Auth().isLoggedIn();
  runApp(MyApp(isLoggedIn: isLogged, isExpired: isExpired));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool isExpired;
  const MyApp({super.key, required this.isLoggedIn,required this.isExpired});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn
          ? HomePage()
          : LoginView(
              errorMessage:
                  isExpired ? "Phiên đăng nhập đã hết hạn" : null,
            ),
    );
  }
}
