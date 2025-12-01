import 'package:app_course_code/Models/login.dart';
import 'package:app_course_code/Models/register.dart';
import 'package:app_course_code/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Future<dynamic> login(LoginRequest request) async {
    // print(jsonEncode(request.toJson()));
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5079/api/Login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return LoginResponse(
          user: User.fromJson(data["user"]),
          token: data["token"],
        );
      } else {
        return false;
      }
    } catch (e) {
      return e;
    }
  }

  Future<Object> register(RegisterRequest request) async {
    // print(jsonEncode(request.toJson()));
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5079/api/Register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e;
    }
  }
  Future<(bool, bool)> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) return (false, false);
    bool isExpired = JwtDecoder.isExpired(token);
    if (isExpired) {
      prefs.remove("token");
      return (false, true);
    }
    return (true, false);
  }
}
