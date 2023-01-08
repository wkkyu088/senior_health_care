import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_health_care/screens/resultScreens/blood_sugar_result.dart';
import 'package:senior_health_care/utils/firestore.dart';
import 'package:senior_health_care/widgets/input/common_input_widget.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/custom_dialog.dart';

import '../../constants.dart';

class BloodSugarInputScreen extends StatefulWidget {
  const BloodSugarInputScreen({Key? key}) : super(key: key);

  @override
  State<BloodSugarInputScreen> createState() => _BloodSugarInputScreenState();
}

class _BloodSugarInputScreenState extends State<BloodSugarInputScreen> {
  String date = DateFormat('yyyyMMdd').format(DateTime.now());
  int selected = 0;
  List<String> selectName = ["아침", "점심", "저녁", "밤"];
  final beforeCont = TextEditingController();
  final afterCont = TextEditingController();
  final memoCont = TextEditingController();
  bool isBeforeEmpty = false;
  bool isAfterEmpty = false;

  void initData() async {
    final users = FirebaseFirestore.instance.collection('users').doc(uid);
    var bloodSugars = users.collection('bloodSugar');
    var v = await bloodSugars.doc(date).get();
    var m = v.data() as Map;

    if (!mounted) return;
    if (m.isNotEmpty) {
      showWarningDialog(
        context,
        "이미 입력한 값이 존재합니다.\n새로 입력하시겠습니까?",
        hasCancel: true,
        oneMorePop: true,
      );
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

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
          setState(() {});
        },
        style: TextButton.styleFrom(
          primary: kGrey,
          backgroundColor: selected == idx ? kMain : kBackground,
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
      appBar: customAppBar("혈당 입력하기", context, hasBack: true),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight - 60 - statusBarHeight - navigationBarHeight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: [
              description("측정 시기를 선택해주세요."),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      radioButton(selectName[0], 0),
                      const SizedBox(width: 10),
                      radioButton(selectName[1], 1),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      radioButton(selectName[2], 2),
                      const SizedBox(width: 10),
                      radioButton(selectName[3], 3),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              customField(
                "식사 전 혈당 값을 입력해주세요.",
                beforeCont,
                Icons.water_drop_rounded,
                "mg/dL",
                "80",
                isBeforeEmpty,
              ),
              const SizedBox(height: 10),
              customField(
                "식사 후 혈당 값을 입력해주세요.",
                afterCont,
                Icons.water_drop_rounded,
                "mg/dL",
                "140",
                isAfterEmpty,
              ),
              const SizedBox(height: 20),
              customMultiField(
                screenWidth,
                "오늘 식단 등을 메모해주세요. (선택)",
                memoCont,
                "밥, 미역국, 김치",
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        if (beforeCont.text == "" || afterCont.text == "") {
                          showWarningDialog(
                              context, "입력하지 않은 필수 값이 있습니다.\n다시 확인해주세요!");
                          if (beforeCont.text == "") {
                            isBeforeEmpty = true;
                            setState(() {});
                          }
                          if (afterCont.text == "") {
                            isAfterEmpty = true;
                            setState(() {});
                          }
                        } else {
                          int before = int.parse(beforeCont.text);
                          int after = int.parse(afterCont.text);

                          print(
                              "$date ${selectName[selected]} $before $after ${memoCont.text}");

                          await InputManager.setBloodSugar(
                              uid,
                              date,
                              selectName[selected],
                              before,
                              after,
                              memoCont.text);

                          if (!mounted) return;

                          if (before < 100 || after < 140) {
                            showResultDialog(
                              context,
                              "정상",
                              "safe",
                              "식사 전 혈당 값 : $before mg/dL\n식사 후 혈당 값 : $after mg/dL",
                              const BloodSugarResultScreen(),
                            );
                          } else if ((before >= 100 && before <= 125) ||
                              (after >= 140 && after <= 199)) {
                            showResultDialog(
                              context,
                              "당뇨 전단계",
                              "warn",
                              "식사 전 혈당 값 : $before mg/dL\n식사 후 혈당 값 : $after mg/dL",
                              const BloodSugarResultScreen(),
                            );
                          } else if (before >= 126 || after >= 200) {
                            showResultDialog(
                              context,
                              "당뇨병",
                              "danger",
                              "식사 전 혈당 값 : $before mg/dL\n식사 후 혈당 값 : $after mg/dL",
                              const BloodSugarResultScreen(),
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
