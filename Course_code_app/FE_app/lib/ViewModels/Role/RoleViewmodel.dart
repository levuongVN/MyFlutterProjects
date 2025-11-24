
import 'package:app_course_code/Models/role.dart';
import 'package:app_course_code/Services/Role/RoleServices.dart';

class RoleViewModel {
  final RoleServices _apiService = RoleServices();
  List<Role> roles = []; // List thay vì single object

  Future<void> getRoles() async {
    roles = await _apiService.fetchRole(); // Nhận List<Role>
    for (var role in roles) {
      print('ID: ${role.id}, Name: ${role.name}, Description: ${role.descriptions}');
    }
  }
}