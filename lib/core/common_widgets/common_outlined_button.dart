import 'package:flutter/material.dart';

class CommonOutlinedButton extends StatelessWidget {
  const CommonOutlinedButton({
    super.key,
    this.isLoading = false,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.radius,
    this.height = 40,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final double? radius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor:
              backgroundColor != null ? WidgetStateProperty.all<Color>(backgroundColor!) : null,
          shape: radius != null
              ? WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
                )
              : null,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ))
            : child,
      ),
    );
  }
}
