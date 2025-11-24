import 'package:flutter/foundation.dart';
import 'package:email_validator/email_validator.dart';

enum UserRole { user, admin }
enum RegisterStep { role, info, verification }

class RegisterViewModel with ChangeNotifier {

  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _phone = '';
  

  UserRole _selectedRole = UserRole.user;
  RegisterStep _currentStep = RegisterStep.role;
  bool _isLoading = false;
  String _error = '';
  bool? _isSuccess;


  String? _fullNameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _phoneError;


  String get fullName => _fullName;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get phone => _phone;
  UserRole get selectedRole => _selectedRole;
  RegisterStep get currentStep => _currentStep;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool? get isSuccess => _isSuccess;
  

  String? get fullNameError => _fullNameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;
  String? get phoneError => _phoneError;


  void setFullName(String value) {
    _fullName = value;
    _fullNameError = null;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    _emailError = null;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _passwordError = null;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    _confirmPasswordError = null;
    notifyListeners();
  }

  void setPhone(String value) {
    _phone = value;
    _phoneError = null;
    notifyListeners();
  }

  void setRole(UserRole role) {
    _selectedRole = role;
    notifyListeners();
  }

  void setStep(RegisterStep step) {
    _currentStep = step;
    notifyListeners();
  }

  bool _validateFullName() {
    if (_fullName.isEmpty) {
      _fullNameError = 'Vui lòng nhập họ tên';
      return false;
    }
    if (_fullName.length < 2) {
      _fullNameError = 'Họ tên quá ngắn';
      return false;
    }
    return true;
  }

  bool _validateEmail() {
    if (_email.isEmpty) {
      _emailError = 'Vui lòng nhập email';
      return false;
    }
    if (!EmailValidator.validate(_email)) {
      _emailError = 'Email không hợp lệ';
      return false;
    }
    return true;
  }

  bool _validatePassword() {
    if (_password.isEmpty) {
      _passwordError = 'Vui lòng nhập mật khẩu';
      return false;
    }
    if (_password.length < 6) {
      _passwordError = 'Mật khẩu phải có ít nhất 6 ký tự';
      return false;
    }
    return true;
  }

  bool _validateConfirmPassword() {
    if (_confirmPassword.isEmpty) {
      _confirmPasswordError = 'Vui lòng xác nhận mật khẩu';
      return false;
    }
    if (_confirmPassword != _password) {
      _confirmPasswordError = 'Mật khẩu xác nhận không khớp';
      return false;
    }
    return true;
  }

  bool _validatePhone() {
    if (_phone.isEmpty) {
      _phoneError = 'Vui lòng nhập số điện thoại';
      return false;
    }
    if (_phone.length < 10) {
      _phoneError = 'Số điện thoại không hợp lệ';
      return false;
    }
    return true;
  }


  void _clearValidationErrors() {
    _fullNameError = null;
    _emailError = null;
    _passwordError = null;
    _confirmPasswordError = null;
    _phoneError = null;
    _error = '';
  }

  // Validate current step
  bool _validateCurrentStep() {
    _clearValidationErrors();
    
    bool isValid = true;

    if (_currentStep == RegisterStep.info) {
      if (!_validateFullName()) isValid = false;
      if (!_validateEmail()) isValid = false;
      if (!_validatePhone()) isValid = false;
      if (!_validatePassword()) isValid = false;
      if (!_validateConfirmPassword()) isValid = false;
    }

    return isValid;
  }

  // Navigation với validation
  void nextStep() {
    if (_currentStep == RegisterStep.info && !_validateCurrentStep()) {
      _error = 'Vui lòng kiểm tra lại thông tin';
      notifyListeners();
      return;
    }

    switch (_currentStep) {
      case RegisterStep.role:
        _currentStep = RegisterStep.info;
        break;
      case RegisterStep.info:
        _currentStep = RegisterStep.verification;
        break;
      case RegisterStep.verification:
        break;
    }
    _clearValidationErrors();
    notifyListeners();
  }

  void previousStep() {
    switch (_currentStep) {
      case RegisterStep.role:
        break;
      case RegisterStep.info:
        _currentStep = RegisterStep.role;
        break;
      case RegisterStep.verification:
        _currentStep = RegisterStep.info;
        break;
    }
    _clearValidationErrors();
    notifyListeners();
  }

  // Business Logic với validation
  Future<void> register() async {
    if (!_validateCurrentStep()) {
      _error = 'Vui lòng kiểm tra lại thông tin';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock success
    _isSuccess = true;
    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _fullName = '';
    _email = '';
    _password = '';
    _confirmPassword = '';
    _phone = '';
    _selectedRole = UserRole.user;
    _currentStep = RegisterStep.role;
    _isLoading = false;
    _error = '';
    _isSuccess = null;
    _clearValidationErrors();
    notifyListeners();
  }
}