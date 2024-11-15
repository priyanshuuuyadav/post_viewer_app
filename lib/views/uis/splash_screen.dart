import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/constant.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        Get.offAll(() => HomeScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "splash",
          child: Image.asset(
            appLogo,
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}
