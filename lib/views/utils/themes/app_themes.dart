import 'package:flutter/material.dart';
import '../colors/colors.dart';

class AppTheme {
  static ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
      scaffoldBackgroundColor: bgColor,
      appBarTheme: AppBarTheme(color: primaryColor.withOpacity(0.1)),
      canvasColor: secondaryColor);
}
