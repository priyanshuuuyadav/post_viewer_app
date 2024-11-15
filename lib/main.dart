import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_posts/views/uis/splash_screen.dart';
import 'package:timer_posts/views/utils/themes/app_themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Assignment App",
      theme: AppTheme.darkTheme(context),
      home: SplashScreen(),
    );
  }
}
