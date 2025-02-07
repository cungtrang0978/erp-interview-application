import 'package:flutter/material.dart';
import 'package:flutter_interview_application/core/utils/validator_utils.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({super.key, this.label = "Password", required this.controller, this.validator});

  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        // prefixIcon: Icon(Icons.lock_outline, color: Colors.blueAccent),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: widget.validator ?? ValidatorUtils.password,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
    );
  }
}
