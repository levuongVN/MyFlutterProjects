import 'package:app_course_code/Models/user.dart';

class LoginRequest {
  String email;
  String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}

class LoginResponse {
  User user;
  String token;

  LoginResponse({required this.user, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: User.fromJson(json["user"]),
      token: json["token"],
    );
  }
}
