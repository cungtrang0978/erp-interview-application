import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';

class AppInputDecoration {
  const AppInputDecoration._();

  static final _borderRadius = BorderRadius.circular(12);

  // static final outlineBorder = OutlineInputBorder(
  //   borderRadius: _borderRadius,
  //   borderSide: const BorderSide(
  //     color: AppColor.black,
  //     width: 1,
  //   ),
  // );

  static final defaultDec = InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(
          color: AppColor.lightGrey4,
          width: 1,
        ),
      ),
      // labelStyle: const TextStyle(color: AppColor.white),
      floatingLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      focusedBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(
          // color: AppColor.blue,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(
          color: AppColor.redError,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(
          color: AppColor.redError,
          width: 1,
        ),
      ),
      suffixIconColor: AppColor.grey,
      errorMaxLines: 4,
      hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14)
      // errorStyle: const TextStyle(fontSize: 0),
      );

  static noneBorderDec({Color? fillColor}) => InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 20),
        hintStyle: AppTextStyle.hint,
        suffixIconColor: AppColor.grey,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        fillColor: fillColor,
        filled: true,
      );

// static const underlineBorderDec = InputDecoration(
//   contentPadding: EdgeInsets.only(bottom: 8, top: 4),
//   hintStyle: AppTextStyle.hint,
//   suffixIconColor: AppColor.grey,
//   enabledBorder: UnderlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColor.grey2,
//       width: 1,
//     ),
//   ),
//   focusedBorder: UnderlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColor.primary,
//       width: 1,
//     ),
//   ),
//   errorBorder: UnderlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColor.red,
//       width: 1,
//     ),
//   ),
//   focusedErrorBorder: UnderlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColor.red,
//       width: 1,
//     ),
//   ),
//   labelStyle: AppTextStyle.label2,
//   hoverColor: AppColor.primary,
//   floatingLabelBehavior: FloatingLabelBehavior.always,
//   errorStyle: AppTextStyle.warningText,
// );
}
