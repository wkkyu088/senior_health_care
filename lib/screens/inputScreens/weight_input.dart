import 'package:flutter/material.dart';
import 'package:senior_health_care/screens/resultScreens/weight_result.dart';
import 'package:senior_health_care/widgets/common_input_widget.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/custom_dialog.dart';

import '../../constants.dart';

class WeightInputScreen extends StatefulWidget {
  const WeightInputScreen({Key? key}) : super(key: key);

  @override
  State<WeightInputScreen> createState() => _WeightInputScreenState();
}

class _WeightInputScreenState extends State<WeightInputScreen> {
  final heightCont = TextEditingController();
  final weightCont = TextEditingController();
  bool isHeightEmpty = false;
  bool isWeightEmpty = false;

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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
              const SizedBox(height: 30),
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
                      onPressed: () {
                        if (heightCont.text == "" || weightCont.text == "") {
                          if (heightCont.text == "") {
                            showWarningDialog(
                                context, "입력하지 않은 필수 값이 있습니다.\n다시 확인해주세요!");
                            isHeightEmpty = true;
                            setState(() {});
                          } else if (weightCont.text == "") {
                            showWarningDialog(
                                context, "입력하지 않은 필수 값이 있습니다.\n다시 확인해주세요!");
                            isWeightEmpty = true;
                            setState(() {});
                          }
                        } else {
                          double height = double.parse(heightCont.text);
                          double weight = double.parse(weightCont.text);
                          double bmi = weight / (height * height * 0.01 * 0.01);

                          print("$height $weight $bmi");

                          if (bmi < 18.5) {
                            showResultDialog(
                              context,
                              "저체중",
                              "danger",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : ${bmi.toStringAsFixed(2)} %",
                              const WeightResultScreen(),
                            );
                          } else if (bmi >= 18.5 && bmi <= 22.9) {
                            showResultDialog(
                              context,
                              "정상 체중",
                              "safe",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : ${bmi.toStringAsFixed(2)} %",
                              const WeightResultScreen(),
                            );
                          } else if (bmi >= 23 && bmi <= 24.9) {
                            showResultDialog(
                              context,
                              "과체중",
                              "safe",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : ${bmi.toStringAsFixed(2)} %",
                              const WeightResultScreen(),
                            );
                          } else if (bmi >= 25 && bmi <= 29.9) {
                            showResultDialog(
                              context,
                              "경도비만",
                              "warn",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : ${bmi.toStringAsFixed(2)} %",
                              const WeightResultScreen(),
                            );
                          } else if (bmi >= 30) {
                            showResultDialog(
                              context,
                              "고도비만",
                              "danger",
                              "키 : $height cm\n몸무게 : $weight kg\nBMI : ${bmi.toStringAsFixed(2)} %",
                              const WeightResultScreen(),
                            );
                          } else {
                            showWarningDialog(context, "측정 불가");
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
