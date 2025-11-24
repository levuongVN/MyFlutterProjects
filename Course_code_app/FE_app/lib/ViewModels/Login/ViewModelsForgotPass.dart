import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPass with ChangeNotifier {
  String _email = '';
  String _error = '';
  bool _isLoading = false;
  bool? _isSucess = null;

  String get email => _email;
  String get error => _error;
  bool get isLoading => _isLoading;
  bool? get isSuccess => _isSucess;

  void setEmail(value) {
    _email = value;
    notifyListeners();
  }

  Future<void> submit() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    if(_email.isEmpty){
      _error = "Vui lòng nhập đủ thông tin";
      _isLoading = false;
      _isSucess = false;
    }
    else if (!EmailValidator.validate(_email)) {
      _error = "Email sai định dạng";
      _isLoading = false;
      _isSucess = false;
    } else {
      _error = "";
      _isLoading = false;
      _isSucess = true;
    }
    notifyListeners();
  }
}
