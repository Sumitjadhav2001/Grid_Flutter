import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType inputType;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;

  CustomTextInput({
    required this.label,
    required this.controller,
    required this.inputType,
    this.focusNode,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
