import 'package:app_course_code/Models/login.dart';
import 'package:app_course_code/Services/Authentication/Auth.dart';
import 'package:flutter/foundation.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  String _error = '';
  bool _isSuccess = false;

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isSuccess => _isSuccess;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> login() async {
    _isLoading = true;
    _error = '';
    if (_email.isEmpty || _password.isEmpty) {
      _isLoading = false;
      _isSuccess = false;
      _error = 'Vui lòng nhập đầy đủ thông tin';
    } else if (!EmailValidator.validate(_email)) {
      _isLoading = false;
      _isSuccess = false;

      _error = "Email không hợp lệ";
    } else if (_password.length < 6) {
      _isLoading = true;
      _isSuccess = false;

      _error = 'Mật khẩu phải có ít nhất 6 ký tự';
    } else {
      _error = '';
      final loginRequest = LoginRequest(
        email: _email,
        password: _password,
      );
      dynamic result = await Auth().login(loginRequest);
      if (result == false) {
        _isSuccess = false;
        _error = 'Sai mật khẩu hoặc tài khoản email';
      } else if (result is LoginResponse) {
        // print(result.token);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", result.token);
        _isSuccess = true;
      } else {
        _isSuccess = false;
        _error = 'Đang có lỗi, vui lòng thử lại sau';
      }
      _isLoading = false;
    }
    notifyListeners();
  }

  void setError(String s) {
      _error = s;
      notifyListeners();
  }
}
