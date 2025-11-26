import 'package:app_course_code/Models/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth {
  
  Future<Object> register(RegisterRequest request) async {
    print(jsonEncode(request.toJson()));
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
}
