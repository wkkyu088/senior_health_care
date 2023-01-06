import 'package:flutter/material.dart';
import 'package:senior_health_care/screens/resultScreens/heart_rate_result.dart';
import 'package:senior_health_care/widgets/common_input_widget.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/custom_dialog.dart';

import '../../constants.dart';

class HeartRateInputScreen extends StatefulWidget {
  const HeartRateInputScreen({Key? key}) : super(key: key);

  @override
  State<HeartRateInputScreen> createState() => _HeartRateInputScreenState();
}

class _HeartRateInputScreenState extends State<HeartRateInputScreen> {
  int selected = 0;
  List<bool> selectList = [true, false];
  final valueCont = TextEditingController();
  bool isValueEmpty = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    Widget radioButton(txt, idx) {
      return TextButton(
        onPressed: () {
          selected = idx;
          for (var i = 0; i < selectList.length; i++) {
            if (i == idx) {
              selectList[i] = true;
            } else {
              selectList[i] = false;
            }
          }
          setState(() {});
        },
        style: TextButton.styleFrom(
          primary: kGrey,
          backgroundColor: selected == idx ? kMain : kWhite,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: selected == idx ? kMain : kGrey, width: 1),
            borderRadius: kBorderRadiusS,
          ),
          minimumSize: Size(screenWidth / 2 - 55, 50),
        ),
        child: Text(
          txt,
          style:
              TextStyle(color: selected == idx ? kWhite : kBlack, fontSize: kS),
        ),
      );
    }

    return Scaffold(
      appBar: customAppBar("심박수 입력하기", context, hasBack: true),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight - 60 - statusBarHeight - navigationBarHeight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: [
              description("측정 시기를 선택해주세요."),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  radioButton("평상시", 0),
                  const SizedBox(width: 10),
                  radioButton("운동 후", 1),
                ],
              ),
              const SizedBox(height: 30),
              customField(
                "심박수 값을 입력해주세요.",
                valueCont,
                Icons.monitor_heart_rounded,
                "bpm",
                "65",
                isValueEmpty,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (valueCont.text == "") {
                          showWarningDialog(
                              context, "입력하지 않은 필수 값이 있습니다.\n다시 확인해주세요!");
                          isValueEmpty = true;
                          setState(() {});
                        } else {
                          int value = int.parse(valueCont.text);

                          if (selected == 1) {
                            value = (value / 1.7).round();
                          }

                          print("$selected $value");

                          if (userGender) {
                            if (value >= 50 && value <= 73) {
                              showResultDialog(
                                context,
                                "좋음",
                                "safe",
                                "심박수 : ${valueCont.text} bpm",
                                const HeartRateResultScreen(),
                              );
                            } else if (value >= 74 && value <= 79) {
                              showResultDialog(
                                context,
                                "평균 이하",
                                "warn",
                                "심박수 : ${valueCont.text} bpm",
                                const HeartRateResultScreen(),
                              );
                            } else if (value >= 80) {
                              showResultDialog(
                                context,
                                "나쁨",
                                "danger",
                                "심박수 : ${valueCont.text} bpm",
                                const HeartRateResultScreen(),
                              );
                            } else {
                              showWarningDialog(context, "측정 불가");
                            }
                          } else {
                            if (value >= 54 && value <= 76) {
                              showResultDialog(
                                context,
                                "좋음",
                                "safe",
                                "심박수 : ${valueCont.text} bpm",
                                const HeartRateResultScreen(),
                              );
                            } else if (value >= 77 && value <= 84) {
                              showResultDialog(
                                context,
                                "평균 이하",
                                "warn",
                                "심박수 : ${valueCont.text} bpm",
                                const HeartRateResultScreen(),
                              );
                            } else if (value >= 85) {
                              showResultDialog(
                                context,
                                "나쁨",
                                "danger",
                                "심박수 : ${valueCont.text} bpm",
                                const HeartRateResultScreen(),
                              );
                            } else {
                              showWarningDialog(context, "측정 불가");
                            }
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
