// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:senior_health_care/main.dart';
import 'package:senior_health_care/screens/singup_screen.dart';
import 'package:senior_health_care/utils/firestore.dart';
import 'package:senior_health_care/widgets/custom_dialog.dart';

class MethodEmail {
  // 이메일로 가입
  static signUpWithEmail(email, pw, age, isMale, height, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pw);
      if (userCredential.user != null) {
        print("회원가입 성공");
        Fluttertoast.showToast(msg: "회원가입 성공");
        await UserManager.setProfile(
            userCredential.user!.uid, age, isMale, height);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBar(startIndex: 2)));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('이미 계정이 있음');
        showWarningDialog(context, "이미 있는 계정입니다.");
      } else if (e.code == 'weak-password') {
        print('비밀번호가 너무 약함');
        showWarningDialog(context, "비밀번호가 너무 약합니다.");
      } else if (e.code == 'invalid-email') {
        print('잘못된 이메일 형식');
        showWarningDialog(context, "잘못된 이메일 형식입니다.");
      } else {
        print('${e.code} : 알 수 없는 오류');
      }
    }
  }

  // 이메일로 로그인
  static signInWithEmail(email, pw, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pw);
      if (userCredential.user != null) {
        print("로그인 성공");
        Fluttertoast.showToast(msg: "로그인 성공");
        await UserManager.getProfile(userCredential.user!.uid);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBar(startIndex: 2)));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('등록되지 않은 이메일');
        showWarningDialog(context, "등록되지 않은 이메일입니다.");
      } else if (e.code == 'wrong-password') {
        print('비밀번호가 틀림');
        showWarningDialog(context, "비밀번호가 틀렸습니다.");
      } else if (e.code == 'invalid-email') {
        print('잘못된 이메일 형식');
        showWarningDialog(context, "잘못된 이메일 형식입니다.");
      } else {
        print(e.code);
      }
    }
  }
}

class MethodGoogle {
  // 구글로 시작
  static signInWithGoogle(context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    var userId = userCredential.user!.uid;

    if (userCredential.user != null) {
      // 구글로 회원가입
      print("구글 로그인 성공");
      Fluttertoast.showToast(msg: "구글 로그인 성공");

      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (user.data() == null) {
        print("회원가입으로 넘어감");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SignUpScreen(isEmail: false, userId: userId)));
      } else {
        // 구글로 로그인
        print("값이 있어서 로그인");
        await UserManager.getProfile(userId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBar(startIndex: 2)));
      }
    }
  }

  // 이메일 가입이 아닐 때 (추후 이동 필요)
  static signUpWithGoogle(context, userId, age, isMale, height) async {
    await UserManager.setProfile(userId, age, isMale, height);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavBar(startIndex: 2)));
  }
}
