import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:senior_health_care/screens/login_screen.dart';
import 'package:senior_health_care/utils/firestore.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/custom_dialog.dart';

import '../constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    // InputManager.setBloodPressure(uid, "20230105", "왼쪽 팔", 120, 76, 75);

    for (var i = 0; i < 30; i++) {
      DateTime now = DateTime.now();
      String date =
          DateFormat('yyyyMMdd').format(now.subtract(Duration(days: i)));

      // // 혈압
      // InputManager.setBloodPressure(
      //     uid,
      //     date,
      //     "왼쪽 팔",
      //     Random().nextInt(40) + 120,
      //     Random().nextInt(10) + 85,
      //     Random().nextInt(15) + 70);

      // // 혈당
      // InputManager.setBloodSugar(uid, date, "아침", Random().nextInt(30) + 100,
      //     Random().nextInt(50) + 140, "");

      // // 심박수
      // InputManager.setHeartRate(uid, date, "평상시", Random().nextInt(10) + 60);

      // // 몸무게
      // double weight = Random().nextDouble() * 5 + 70;
      // double bmi = weight / (userHeight * userHeight * 0.01 * 0.01);
      // bmi = double.parse(bmi.toStringAsFixed(2));
      // InputManager.setWeight(uid, date, userHeight, weight, bmi);
    }

    Widget settingItem(header, body) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                header,
                style: TextStyle(color: kBlack, fontSize: kS),
              ),
            ),
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: kBorderRadiusM,
                boxShadow: [
                  BoxShadow(
                    color: kGrey.withOpacity(0.25),
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: body,
            ),
          ],
        ),
      );
    }

    Widget subHeader(txt) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: kMain,
          borderRadius: kBorderRadiusS,
        ),
        child: Text(
          txt,
          style: TextStyle(color: kWhite, fontSize: kXS),
        ),
      );
    }

    return Scaffold(
      appBar: customAppBar("설정", context, hasBack: false),
      body: Container(
        width: screenWidth,
        height: screenHeight - statusBarHeight - navigationBarHeight - 130,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                settingItem(
                  "가입 정보",
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          subHeader("이메일"),
                          const SizedBox(width: 10),
                          Text(
                            FirebaseAuth.instance.currentUser!.email.toString(),
                            style: TextStyle(color: kBlack, fontSize: kM),
                          ),
                        ],
                      ),
                      Container(
                        height: 0.6,
                        color: kLightGrey,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                subHeader("나이"),
                                const SizedBox(width: 10),
                                Text(
                                  "$userAge세",
                                  style: TextStyle(color: kBlack, fontSize: kM),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                subHeader("성별"),
                                const SizedBox(width: 10),
                                Text(
                                  userGender ? "남성" : "여성",
                                  style: TextStyle(color: kBlack, fontSize: kM),
                                ),
                                Icon(
                                  userGender
                                      ? Icons.male_rounded
                                      : Icons.female_rounded,
                                  size: 20,
                                  color: userGender ? Colors.blue : Colors.red,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                settingItem(
                  "디바이스 연동",
                  Text(
                    "연동 안됨",
                    style: TextStyle(color: kGrey, fontSize: kM),
                  ),
                ),
              ],
            ),
            Text("uid : $uid"),
            // const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    showWarningDialog(
                      context,
                      "정말 로그아웃 하시겠습니까?",
                      hasCancel: true,
                    );
                    print("로그아웃됨");
                    Fluttertoast.showToast(msg: "로그아웃 되었습니다.");
                    uid = "";
                    userAge = 0;
                    userGender = true;
                    userHeight = 0.0;
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  style: TextButton.styleFrom(
                    primary: kLightGrey,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "로그아웃",
                    style: TextStyle(fontSize: kXS, color: kGrey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showWarningDialog(
                      context,
                      "모든 정보가 지워집니다.\n정말 탈퇴 하시겠습니까?",
                      hasCancel: true,
                    );
                    // print("회원탈퇴됨");
                    // Fluttertoast.showToast(msg: "탈퇴 되었습니다.");
                    // uid = "";
                    // userAge = 0;
                    // userGender = true;
                    // userHeight = 0.0;
                    // FirebaseAuth.instance.signOut();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoginScreen()));
                  },
                  style: TextButton.styleFrom(
                    primary: kLightGrey,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "회원탈퇴",
                    style: TextStyle(fontSize: kXS, color: Colors.red[300]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
