import 'package:flutter/material.dart';

class RememberMeCheckbox extends StatefulWidget {
  const RememberMeCheckbox({super.key, required this.onChanged, required this.initialValue});

  final ValueChanged<bool> onChanged;
  final bool initialValue;

  @override
  State<RememberMeCheckbox> createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  late bool rememberMe = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: (value) {
            setState(() {
              rememberMe = value!;
              widget.onChanged(value);
            });
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              rememberMe = !rememberMe;
              widget.onChanged(rememberMe);
            });
          },
          child: const Text("Remember Me"),
        ),
      ],
    );
  }
}
