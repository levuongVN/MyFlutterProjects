import 'package:app_course_code/ViewModels/Register/ViewModelsRegister.dart';
import 'package:flutter/material.dart';
import 'register_text_field.dart';

class InfoStep extends StatelessWidget {
  final RegisterViewModel viewModel;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const InfoStep({
    super.key,
    required this.viewModel,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin cá nhân',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Nhập thông tin cơ bản của bạn',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 40),

        // Form fields với errorText từ ViewModel
        RegisterTextField(
          controller: fullNameController,
          label: 'Họ và tên',
          hint: 'Nhập họ tên đầy đủ',
          icon: Icons.person,
          errorText: viewModel.fullNameError,
          onChanged: viewModel.setFullName,
        ),
        const SizedBox(height: 16),
        RegisterTextField(
          controller: emailController,
          label: 'Email',
          hint: 'Nhập địa chỉ email',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          errorText: viewModel.emailError,
          onChanged: viewModel.setEmail,
        ),
        const SizedBox(height: 16),
        RegisterTextField(
          controller: phoneController,
          label: 'Số điện thoại',
          hint: 'Nhập số điện thoại',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          errorText: viewModel.phoneError,
          onChanged: viewModel.setPhone,
        ),
        const SizedBox(height: 16),
        RegisterTextField(
          controller: passwordController,
          label: 'Mật khẩu',
          hint: 'Nhập mật khẩu',
          icon: Icons.lock,
          obscureText: true,
          errorText: viewModel.passwordError,
          onChanged: viewModel.setPassword,
        ),
        const SizedBox(height: 16),
        RegisterTextField(
          controller: confirmPasswordController,
          label: 'Xác nhận mật khẩu',
          hint: 'Nhập lại mật khẩu',
          icon: Icons.lock_outline,
          obscureText: true,
          errorText: viewModel.confirmPasswordError,
          onChanged: viewModel.setConfirmPassword,
        ),
      ],
    );
  }
}