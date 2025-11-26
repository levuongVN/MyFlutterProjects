import 'package:flutter/foundation.dart';
import 'package:email_validator/email_validator.dart';

class LoginViewModel with ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  String _error = '';
  
  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  String get error => _error;

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
      _error = 'Vui lòng nhập đầy đủ thông tin';
    }else if(!EmailValidator.validate(_email)){
      _error="Email không hợp lệ";
    } 
    else if (_password.length < 6) {
      _error = 'Mật khẩu phải có ít nhất 6 ký tự';
    } else {
      _error = '';
    }
    
    notifyListeners();
  }
}