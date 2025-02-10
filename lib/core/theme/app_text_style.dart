import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTextStyle {
  const AppTextStyle._();

  static const TextStyle selectedBottomBarTextStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColor.primary,
  );

  static const TextStyle unselectedBottomBarTextStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle textButton = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    // color: AppColor.darkGrey,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle textInput = TextStyle(
    fontSize: 12,
    color: AppColor.white,
  );

  static const TextStyle textInput2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle hint = TextStyle(
    fontWeight: FontWeight.w400,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
  );
}
