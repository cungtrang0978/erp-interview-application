import 'package:flutter/material.dart';

import '../utils/validator_utils.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Email",
      ),
      validator: ValidatorUtils.email,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
