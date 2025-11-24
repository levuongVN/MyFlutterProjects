import 'package:app_course_code/ViewModels/Register/ViewModelsRegister.dart';
import 'package:flutter/material.dart';
class RegisterProgressIndicator extends StatelessWidget {
  final RegisterViewModel viewModel;

  const RegisterProgressIndicator({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProgressStep('Vai trò', 1, RegisterStep.role),
          _buildProgressStep('Thông tin', 2, RegisterStep.info),
          _buildProgressStep('Xác thực', 3, RegisterStep.verification),
        ],
      ),
    );
  }

  Widget _buildProgressStep(String title, int stepNumber, RegisterStep step) {
    final isActive = viewModel.currentStep == step;
    final isCompleted = viewModel.currentStep.index > step.index;
    
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive || isCompleted 
                ? Colors.blue[800] 
                : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : Text(
                    '$stepNumber',
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue[800] : Colors.grey[600],
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}