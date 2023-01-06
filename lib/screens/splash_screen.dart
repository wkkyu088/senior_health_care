import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_health_care/main.dart';
import 'package:senior_health_care/screens/login_screen.dart';
import 'package:senior_health_care/utils/firestore.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() async {
    return Timer(const Duration(milliseconds: 1000), initApp);
  }

  void initApp() async {
    // FirebaseAuth.instance.signOut();
    var currentUser = FirebaseAuth.instance.currentUser;
    print("current user : ${currentUser?.email}");

    if (currentUser != null) {
      await UserManager.getProfile(currentUser.uid);

      if (!mounted) return;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  const BottomNavBar(startIndex: 2)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen()));
    }
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
