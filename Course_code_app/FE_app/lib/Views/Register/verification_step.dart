import 'package:app_course_code/ViewModels/Register/ViewModelsRegister.dart';
import 'package:flutter/material.dart';

class VerificationStep extends StatelessWidget {
  final RegisterViewModel viewModel;

  const VerificationStep({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Xác thực tài khoản',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Hoàn tất đăng ký tài khoản',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 40),

        // Summary Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    viewModel.selectedRole == UserRole.user
                        ? Icons.person
                        : Icons.admin_panel_settings,
                    color: Colors.blue[800],
                  ),
                  title: Text(
                    viewModel.selectedRole == UserRole.user
                        ? 'Người dùng'
                        : 'Quản trị viên',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.grey),
                  title: const Text('Họ tên'),
                  subtitle: Text(viewModel.fullName),
                ),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.grey),
                  title: const Text('Email'),
                  subtitle: Text(viewModel.email),
                ),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.grey),
                  title: const Text('Số điện thoại'),
                  subtitle: Text(viewModel.phone),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}