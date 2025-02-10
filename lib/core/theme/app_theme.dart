import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_input_decoration.dart';

ThemeData darkTheme = ThemeData(
  colorSchemeSeed: Colors.blue,
  scaffoldBackgroundColor: Colors.grey.shade100,

  // brightness: Brightness.dark,
  // primaryColor: AppColor.red,
  // primarySwatch: Colors.red,
  // textTheme: GoogleFonts.beVietnamProTextTheme().copyWith(
  //   titleMedium: const TextStyle(color: AppColor.primary),
  // ),
  // fontFamily: FontFamily.beVietnamPro,
  // textTheme: const TextTheme(
  //   labelLarge: AppTextStyle.button,
  //   // displaySmall: AppTextStyle.title,
  //   // bodyMedium: AppTextStyle.bodyMedium,
  //   // titleMedium: AppTextStyle.textInput,
  // ).apply(
  //   bodyColor: AppColor.white,
  // ),
  // cardColor: AppColor.darkGrey3,
  // cardTheme: const CardTheme(
  //   elevation: 4,
  //   color: AppColor.white,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(12)),
  //   ),
  // ),
  // scaffoldBackgroundColor: AppColor.darkGrey2,
  // colorScheme: const ColorScheme.dark(
  //   surface: AppColor.red,
  //   primary: AppColor.white,
  //   error: AppColor.redError,
  // ),
  // elevatedButtonTheme: _elevatedButtonTheme,
  inputDecorationTheme: AppInputDecoration.defaultDec,
  // outlinedButtonTheme: _outlinedButtonTheme,
  // textButtonTheme: _textButtonTheme,
  // appBarTheme: _appBarTheme,
  // bottomNavigationBarTheme: _bottomNavigationBarTheme,
  // dividerTheme: _dividerTheme,
  // bottomSheetTheme: const BottomSheetThemeData(
  //   elevation: 0,
  //   modalBackgroundColor: AppColor.black2,
  // ),
  // dropdownMenuTheme: DropdownMenuThemeData(
  //   textStyle: AppTextStyle.bodyMedium,
  //   menuStyle: MenuStyle(
  //     backgroundColor: WidgetStateProperty.resolveWith<Color>(
  //       (Set<WidgetState> states) {
  //         if (states.contains(WidgetState.disabled)) {
  //           return AppColor.lightGrey;
  //         }
  //         return AppColor.white;
  //       },
  //     ),
  //   ),
  // ),
);

const _bottomNavigationBarTheme = BottomNavigationBarThemeData(
  elevation: 0,
  backgroundColor: AppColor.black3,
  selectedItemColor: AppColor.orange,
  unselectedItemColor: AppColor.white,
  // selectedLabelStyle: AppTextStyle.selectedBottomBarTextStyle,
  // unselectedLabelStyle: AppTextStyle.unselectedBottomBarTextStyle,
  type: BottomNavigationBarType.fixed,
);

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
      // backgroundColor: AppColor.primary,
      // disabledBackgroundColor: AppColor.lightGrey,
      // disabledForegroundColor: AppColor.lightGrey2,
      // foregroundColor: AppColor.white,
      // splashFactory: NoSplash.splashFactory,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(5),
      // ),
      // padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
      ),
);

final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
          // backgroundColor: AppColor.white,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(5),
          // ),
          // // side: const BorderSide(color: AppColor.primary),
          // alignment: Alignment.center,
          // foregroundColor: AppColor.primary,
          // disabledForegroundColor: AppColor.grey,
          // disabledBackgroundColor: AppColor.lightGrey,
          // splashFactory: NoSplash.splashFactory,
          // padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
          )
      .copyWith(
    side: WidgetStateProperty.resolveWith<BorderSide>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return const BorderSide(color: AppColor.lightGrey);
        }
        return const BorderSide(color: AppColor.primary);
      },
    ),
  ),
);

final _textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
      // // foregroundColor: AppColor.primary,
      // textStyle: const TextStyle(
      //   decoration: TextDecoration.underline,
      // ),
      //
      // // splashFactory: NoSplash.splashFactory,
      // // shape: RoundedRectangleBorder(
      // //   borderRadius: BorderRadius.circular(5),
      // // ),
      //
      // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      ),
);

const _appBarTheme = AppBarTheme(
  backgroundColor: AppColor.darkGrey3,
  elevation: 0,
  scrolledUnderElevation: 0,
);

const _dividerTheme = DividerThemeData(
  color: AppColor.lightGrey2,
  thickness: 1,
  space: 0,
);
