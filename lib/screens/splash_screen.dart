import 'dart:async';
import 'package:flutter/material.dart';
import 'package:senior_health_care/main.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() async {
    return Timer(const Duration(milliseconds: 2000), initApp);
  }

  void initApp() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.6,
          child: Image.asset('assets/images/logo1.png'),
        ),
      ),
    );
  }
}
