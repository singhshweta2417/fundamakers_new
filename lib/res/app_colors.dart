import 'package:flutter/material.dart';

class AppColors {
  static const themeGreenColor = Color(0xFF08bf40);
  static const lightGreenColor = Color(0xFF81c784);
  static const themeWhiteColor = Color(0xFFffffff);
  static const textButtonColor = Color(0xFF152854);
  static const lastButtonColor = Color(0xFFce0a0a);
  static const lightRedColor = Color(0xFFEF5350);
  static const gradientFirstColor = Color(0xFF152854);
  static const gradientSecondColor = Color(0xFF4b6cb7);
  static const greyColor = Color(0xFF757575);
  static const blackColor = Color(0xFF000000);
  static const LinearGradient gradientDisable = LinearGradient(
    colors: [ AppColors.gradientSecondColor,
      AppColors.gradientSecondColor],
    tileMode: TileMode.clamp,
    begin: Alignment.topRight,
    end: Alignment.centerLeft,
  );
  static const RadialGradient radialGradient = RadialGradient(
    colors: [gradientFirstColor, gradientSecondColor],
    center: Alignment.center,
    radius: 0.8,
  );
}
