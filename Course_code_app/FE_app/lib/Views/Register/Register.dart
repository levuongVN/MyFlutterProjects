import 'package:app_course_code/ViewModels/Register/ViewModelsRegister.dart';
import 'package:app_course_code/Views/Cards/error_card.dart';
import 'package:app_course_code/Views/Cards/success_card.dart';
import 'package:app_course_code/Views/Register/info_steps.dart';
import 'package:app_course_code/Views/Register/register_navigation_buttons.dart';
import 'package:app_course_code/Views/Register/register_progress_indicator.dart';
import 'package:app_course_code/Views/Register/role_selection_step.dart';
import 'package:app_course_code/Views/Register/verification_step.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = RegisterViewModel();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);
  }

  void _onViewModelChanged() {
    setState(() {});
    if (_viewModel.isSuccess == true) {
      Navigator.pop(context);
    }
  }

  void _register() => _viewModel.register();
  void _backToLogin() => Navigator.pop(context);

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _backToLogin,
        ),
        title: const Text('Đăng ký tài khoản'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            RegisterProgressIndicator(viewModel: _viewModel),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    if (_viewModel.currentStep == RegisterStep.role)
                      RoleSelectionStep(viewModel: _viewModel),

                    if (_viewModel.currentStep == RegisterStep.info)
                      InfoStep(
                        viewModel: _viewModel,
                        fullNameController: _fullNameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),

                    if (_viewModel.currentStep == RegisterStep.verification)
                      VerificationStep(viewModel: _viewModel),

                    // Hiển thị lỗi
                    if (_viewModel.error.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      ErrorCard(error: _viewModel.error),
                    ],

                    // Hiển thị thành công
                    if (_viewModel.isSuccess == true) ...[
                      const SizedBox(height: 16),
                      const SuccessCard(),
                    ],

                    const SizedBox(height: 32),

                    // Navigation Buttons
                    RegisterNavigationButtons(
                      viewModel: _viewModel,
                      onRegister: _register,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
