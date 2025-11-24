import 'package:app_course_code/ViewModels/Register/ViewModelsRegister.dart';
import 'package:flutter/material.dart';

class RegisterNavigationButtons extends StatelessWidget {
  final RegisterViewModel viewModel;
  final VoidCallback onRegister;

  const RegisterNavigationButtons({
    super.key,
    required this.viewModel,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back Button
        if (viewModel.currentStep != RegisterStep.role)
          Expanded(
            child: OutlinedButton(
              onPressed: viewModel.previousStep,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('QUAY LẠI'),
            ),
          ),
        
        if (viewModel.currentStep != RegisterStep.role) 
          const SizedBox(width: 16),

        // Next/Register Button
        Expanded(
          child: ElevatedButton(
            onPressed: viewModel.isLoading ? null : () {
              if (viewModel.currentStep == RegisterStep.verification) {
                onRegister();
              } else {
                viewModel.nextStep();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: viewModel.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text(
                    viewModel.currentStep == RegisterStep.verification
                        ? 'HOÀN TẤT ĐĂNG KÝ'
                        : 'TIẾP THEO',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}