import 'package:app_course_code/ViewModels/Register/ViewModelsRegister.dart';
import 'package:flutter/material.dart';

class RoleSelectionStep extends StatelessWidget {
  final RegisterViewModel viewModel;

  const RoleSelectionStep({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chọn loại tài khoản',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Chọn vai trò phù hợp với nhu cầu của bạn',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 40),

        // User Card
        _buildRoleCard(
          title: 'Người dùng',
          subtitle: 'Bắt đầu hành trình học code?',
          icon: Icons.person,
          role: UserRole.user,
          color: Colors.blue,
        ),
        const SizedBox(height: 16),

        // Admin Card
        _buildRoleCard(
          title: 'Quản trị viên',
          subtitle: 'Bạn muốn đóng góp các khoá học giá trị?',
          icon: Icons.admin_panel_settings,
          role: UserRole.admin,
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required UserRole role,
    required MaterialColor color,
  }) {
    final isSelected = viewModel.selectedRole == role;
    
    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? color[50] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? color : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: color),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color[800],
          ),
        ),
        subtitle: Text(subtitle),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: color)
            : const Icon(Icons.radio_button_unchecked),
        onTap: () => viewModel.setRole(role),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}