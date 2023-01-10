import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_health_care/screens/resultScreens/weight_result.dart';
import 'package:senior_health_care/utils/firestore.dart';
import 'package:senior_health_care/widgets/input/common_input_widget.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/custom_dialog.dart';

import '../../constants.dart';

class WeightInputScreen extends StatefulWidget {
  const WeightInputScreen({Key? key}) : super(key: key);

  @override
  State<WeightInputScreen> createState() => _WeightInputScreenState();
}

class _WeightInputScreenState extends State<WeightInputScreen> {
  String date = DateFormat('yyyyMMdd').format(DateTime.now());
  final heightCont = TextEditingController();
  final weightCont = TextEditingController();
  bool isHeightEmpty = false;
  bool isWeightEmpty = false;

  void initData() async {
    final users = FirebaseFirestore.instance.collection('users').doc(uid);
    var weights = users.collection('weight');
    var v = await weights.doc(date).get();
    var m = v.data() as Map;

    if (!mounted) return;
    if (m.isNotEmpty) {
      twoButtonDialog(
        context,
        "이미 입력한 값이 존재합니다.\n새로 입력하시겠습니까?",
        () {
          Navigator.pop(context);
        },
        oneMorePop: true,
      );
    }
  }

  @override
  void initState() {
    heightCont.text = userHeight.toString();
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: customAppBar("몸무게 입력하기", context, hasBack: true),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight - 60 - statusBarHeight - navigationBarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              customField(
                "키를 입력해주세요.",
                heightCont,
                Icons.straighten_rounded,
                "cm",
                "175.0",
                isHeightEmpty,
              ),
              const SizedBox(height: 20),
              customField(
                "몸무게를 입력해주세요.",
                weightCont,
                Icons.monitor_weight_rounded,
                "kg",
                "75.0",
                isWeightEmpty,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        if (heightCont.text == "" || weightCont.text == "") {
                          if (heightCont.text == "") {
                            oneButtonDialog(
                                context, "입력하지 않은 필수 값이 있습니다.\n다시 확인해주세요!");
                            isHeightEmpty = true;
                            setState(() {});
                          } else if (weightCont.text == "") {
                            oneButtonDialog(
                                context, "입력하지 않은 필수 값이 있습니다.\n다시 확인해주세요!");
                            isWeightEmpty = true;
                            setState(() {});
                          }
                        } else {
                          double height = double.parse(heightCont.text);
                          double weight = double.parse(weightCont.text);
                          double bmi = weight / (height * height * 0.01 * 0.01);
                          bmi = double.parse(bmi.toStringAsFixed(2));

                          userHeight = height;
                          await UserManager.setProfile(
                              uid, userAge, userGender, height);
                          await InputManager.setWeight(
                              uid, date, height, weight, bmi);

                          print("$date $height $weight $bmi $userHeight");

                          if (!mounted) return;
                          if (bmi < 18.5) {
                            resultDialog(
                              context,
                              "저체중",
                              "danger",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : $bmi %",
                              const WeightResultScreen(),
                            );
                          } else if (bmi >= 18.5 && bmi <= 22.9) {
                            resultDialog(
                              context,
                              "정상 체중",
                              "safe",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : $bmi %",
                              const WeightResultScreen(),
                            );
                          } else if (bmi >= 23 && bmi <= 24.9) {
                            resultDialog(
                              context,
                              "과체중",
                              "safe",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : $bmi %",
                              const WeightResultScreen(),
                            );
                          } else if (bmi >= 25 && bmi <= 29.9) {
                            resultDialog(
                              context,
                              "경도비만",
                              "warn",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : $bmi %",
                              const WeightResultScreen(),
                            );
                          } else if (bmi >= 30) {
                            resultDialog(
                              context,
                              "고도비만",
                              "danger",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : $bmi %",
                              const WeightResultScreen(),
                            );
                          } else {
                            oneButtonDialog(context, "측정 불가");
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: kWhite,
                        backgroundColor: kMain,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: kBorderRadiusS),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('입력', style: TextStyle(fontSize: kM))],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
