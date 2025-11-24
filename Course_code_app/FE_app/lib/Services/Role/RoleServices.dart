import 'dart:convert';
import 'package:app_course_code/Models/role.dart';
import 'package:http/http.dart' as http;

class RoleServices {
  Future<List<Role>> fetchRole() async {
    final response = await http.get(Uri.parse('http://localhost:5079/api/Role'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body); // list datas
      return jsonList.map((jsonItem) => Role.fromJson(jsonItem)).toList(); // convert each data to obj
    } else {
      throw Exception('Failed to load user');
    }
  }
}