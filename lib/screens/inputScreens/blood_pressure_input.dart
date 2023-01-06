import 'package:flutter/material.dart';
import 'package:senior_health_care/screens/resultScreens/blood_pressure_result.dart';
import 'package:senior_health_care/widgets/common_input_widget.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/custom_dialog.dart';

import '../../constants.dart';

class BloodPressureInputScreen extends StatefulWidget {
  const BloodPressureInputScreen({Key? key}) : super(key: key);

  @override
  State<BloodPressureInputScreen> createState() =>
      _BloodPressureInputScreenState();
}

class _BloodPressureInputScreenState extends State<BloodPressureInputScreen> {
  int selected = 0;
  List<bool> selectList = [true, false, false, false];
  final sysCont = TextEditingController();
  final diaCont = TextEditingController();
  final pulCont = TextEditingController();
  bool isSysEmpty = false;
  bool isDiaEmpty = false;
  bool isPulEmpty = false;

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
      appBar: customAppBar("혈압 입력하기", context, hasBack: true),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight - 60 - statusBarHeight - navigationBarHeight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: [
              description("측정 위치를 선택해주세요."),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  radioButton("오른쪽 팔", 0),
                  const SizedBox(width: 10),
                  radioButton("왼쪽 팔", 1),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  radioButton("오른쪽 다리", 2),
                  const SizedBox(width: 10),
                  radioButton("왼쪽 다리", 3),
                ],
              ),
              const SizedBox(height: 30),
              customField(
                "수축기 혈압(SYS)을 입력해주세요.",
                sysCont,
                Icons.favorite_rounded,
                "mmHg",
                "120",
                isSysEmpty,
              ),
              const SizedBox(height: 10),
              customField(
                "이완기 혈압(DIA)을 입력해주세요.",
                diaCont,
                Icons.favorite_rounded,
                "mmHg",
                "82",
                isDiaEmpty,
              ),
              const SizedBox(height: 10),
              customField(
                "분당 맥박수(PUL)를 입력해주세요.",
                pulCont,
                Icons.show_chart_rounded,
                "bpm",
                "75",
                isPulEmpty,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (sysCont.text == "" ||
                            diaCont.text == "" ||
                            pulCont.text == "") {
                          showWarningDialog(
                              context, "입력하지 않은 필수 값이 있습니다.\n다시 확인해주세요!");
                          if (sysCont.text == "") {
                            isSysEmpty = true;
                            setState(() {});
                          }
                          if (diaCont.text == "") {
                            isDiaEmpty = true;
                            setState(() {});
                          }
                          if (pulCont.text == "") {
                            isPulEmpty = true;
                            setState(() {});
                          }
                        } else {
                          int sys = int.parse(sysCont.text);
                          int dia = int.parse(diaCont.text);
                          int pul = int.parse(pulCont.text);

                          print("$selected $sys $dia $pul");

                          if (sys < 120 && dia < 80) {
                            showResultDialog(
                              context,
                              "정상 혈압",
                              "safe",
                              "수축기 혈압 : $sys mmHg\n이완기 혈압 : $dia mmHg\n분당 맥박수 : $pul bpm",
                              const BloodPressureResultScreen(),
                            );
                          } else if (sys >= 140 && dia < 90) {
                            showResultDialog(
                              context,
                              "수축기 단독 고혈압",
                              "danger",
                              "수축기 혈압 : $sys mmHg\n이완기 혈압 : $dia mmHg\n분당 맥박수 : $pul bpm",
                              const BloodPressureResultScreen(),
                            );
                          } else if (sys >= 120 && sys <= 129 && dia < 80) {
                            showResultDialog(
                              context,
                              "주의혈압",
                              "warn",
                              "수축기 혈압 : $sys mmHg\n이완기 혈압 : $dia mmHg\n분당 맥박수 : $pul bpm",
                              const BloodPressureResultScreen(),
                            );
                          } else if ((sys >= 130 && sys <= 139) ||
                              (dia >= 80 && dia <= 89)) {
                            showResultDialog(
                              context,
                              "고혈압전단계",
                              "warn",
                              "수축기 혈압 : $sys mmHg\n이완기 혈압 : $dia mmHg\n분당 맥박수 : $pul bpm",
                              const BloodPressureResultScreen(),
                            );
                          } else if ((sys >= 120 && sys <= 159) ||
                              (dia >= 90 && dia <= 99)) {
                            showResultDialog(
                              context,
                              "고혈압 1기",
                              "danger",
                              "수축기 혈압 : $sys mmHg\n이완기 혈압 : $dia mmHg\n분당 맥박수 : $pul bpm",
                              const BloodPressureResultScreen(),
                            );
                          } else if (sys >= 160 || dia >= 100) {
                            showResultDialog(
                              context,
                              "고혈압 2기",
                              "danger",
                              "수축기 혈압 : $sys mmHg\n이완기 혈압 : $dia mmHg\n분당 맥박수 : $pul bpm",
                              const BloodPressureResultScreen(),
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
