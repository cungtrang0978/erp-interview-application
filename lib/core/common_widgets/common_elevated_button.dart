import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  const CommonElevatedButton({
    super.key,
    this.isLoading = false,
    required this.child,
    this.onPressed,
    this.height = 48,
    this.suffix,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.backgroundColor,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final Color? backgroundColor;
  final Widget? suffix;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              padding: WidgetStateProperty.all(padding),
              backgroundColor: backgroundColor != null && onPressed != null
                  ? WidgetStateProperty.all(backgroundColor)
                  : null,
            ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ))
            : suffix == null
                ? child
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: false,
                        child: suffix!,
                      ),
                      child,
                      suffix!,
                    ],
                  ),
      ),
    );
  }
}
