import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? errorText;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final bool obscureText;

  const RegisterTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.errorText,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        errorText: errorText, // ← Hiển thị lỗi từ ViewModel
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}