import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../theme/app_color.dart';
import 'common_elevated_button.dart';

class CommonPopup extends StatelessWidget {
  const CommonPopup(
      {super.key,
      this.title,
      this.message,
      this.confirmButtonText,
      this.cancelButtonText,
      this.onConfirm,
      this.onCancel,
      this.icon,
      this.messageWidget})
      : assert(message != null || messageWidget != null);

  final String? title;
  final String? message;
  final Widget? messageWidget;
  final String? confirmButtonText;
  final String? cancelButtonText;
  final Widget? icon;
  final void Function(BuildContext context)? onConfirm;
  final void Function(BuildContext context)? onCancel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: AppColor.darkGrey2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      children: [
                        if (icon != null)
                          Column(
                            children: [
                              icon!,
                              const SizedBox(height: 16),
                            ],
                          ),
                        if (title != null)
                          Column(
                            children: [
                              Text(
                                title ?? '',
                                style: Theme.of(context).textTheme.labelLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        message != null
                            ? Text(
                                message!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14),
                              )
                            : messageWidget!
                      ],
                    ),
                  ),
                  confirmButtonText == null && cancelButtonText != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 8),
                            const Divider(height: 2, thickness: 2, color: AppColor.redError),
                            TextButton(
                              child: Text(
                                cancelButtonText!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, decoration: TextDecoration.none),
                              ),
                              onPressed: () {
                                onCancel?.call(context);
                              },
                            )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (cancelButtonText != null)
                                Expanded(
                                  child: TextButton(
                                    child: Text(
                                      cancelButtonText!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.none),
                                    ),
                                    onPressed: () {
                                      onCancel?.call(context);
                                    },
                                  ),
                                ),
                              if (cancelButtonText != null && confirmButtonText != null)
                                const SizedBox(width: 8),
                              if (confirmButtonText != null)
                                Expanded(
                                  child: CommonElevatedButton(
                                    height: 40,
                                    child: AutoSizeText(confirmButtonText!),
                                    onPressed: () {
                                      onConfirm?.call(context);
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
