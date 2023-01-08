import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/result/common_chart_widget.dart';
import 'package:senior_health_care/widgets/result/result_toggle_buttons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants.dart';

class BloodSugarResultScreen extends StatefulWidget {
  const BloodSugarResultScreen({Key? key}) : super(key: key);

  @override
  State<BloodSugarResultScreen> createState() => _BloodSugarResultScreenState();
}

class _BloodSugarResultScreenState extends State<BloodSugarResultScreen> {
  List<bool> selectedList = [true, false];
  List<double> beforeWeeklyList = [100, 100, 100, 100, 100, 100, 100];
  List<double> afterWeeklyList = [140, 140, 140, 140, 140, 140, 140];
  List<double> beforeMonthlyList = [100, 100, 100, 100];
  List<double> afterMonthlyList = [140, 140, 140, 140];

  _future() async {
    final users = FirebaseFirestore.instance.collection('users');
    DateTime now = DateTime.now();

    var v;
    for (var i = 0; i < 7; i++) {
      String date =
          DateFormat('yyyyMMdd').format(now.subtract(Duration(days: i)));
      var bloodSugars =
          await users.doc(uid).collection('bloodSugar').doc(date).get();

      // 만약 해당 날짜의 데이터가 없다면?
      if (bloodSugars.data() != null) {
        v = bloodSugars.data() as Map;

        beforeWeeklyList[i] = double.parse(v['before'].toString());
        afterWeeklyList[i] = double.parse(v['after'].toString());

        print("$date $v");
      } else {
        beforeWeeklyList.add(-1);
        afterWeeklyList.add(-1);

        print("$date -1");
      }
    }
    print(beforeWeeklyList.toString());
    print(afterWeeklyList.toString());

    for (var i = 0; i < 4; i++) {
      double temp1 = 0;
      double temp2 = 0;
      for (var j = 0; j < 7; j++) {
        String date = DateFormat('yyyyMMdd')
            .format(now.subtract(Duration(days: 7 * i + j)));
        var bloodSugars =
            await users.doc(uid).collection('bloodSugar').doc(date).get();

        // 만약 해당 날짜의 데이터가 없다면?
        if (bloodSugars.data() != null) {
          v = bloodSugars.data() as Map;

          temp1 += double.parse(v['before'].toString());
          temp2 += double.parse(v['after'].toString());

          print("${7 * i + j} $date $v");
        } else {
          beforeMonthlyList.add(-1);
          afterMonthlyList.add(-1);

          print("$date -1");
        }
      }
      print("temp1 $temp1 temp2 $temp2");
      beforeMonthlyList[i] = temp1 / 7;
      afterMonthlyList[i] = temp2 / 7;
    }
    print(beforeMonthlyList.toString());
    print(afterMonthlyList.toString());

    return v;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("혈당 분석보기", context, hasBack: true),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: kBorderRadiusM,
                  boxShadow: [
                    BoxShadow(
                      color: kGrey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    resultToggleButtons(selectedList, (value) {
                      if (value == 0) {
                        selectedList[0] = true;
                        selectedList[1] = false;
                      } else {
                        selectedList[0] = false;
                        selectedList[1] = true;
                      }
                      setState(() {});
                    }),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          chartLegend(kDanger, "혈당 값 (식사 전)"),
                          const SizedBox(width: 10),
                          chartLegend(kBS.withRed(255), "혈당 값 (식사 후)"),
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: _future(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              width: 300,
                              height: 300,
                              alignment: Alignment.center,
                              child: LoadingAnimationWidget.waveDots(
                                  color: kMain, size: 30),
                            );
                          }
                          return AspectRatio(
                            aspectRatio: 1.05,
                            child: Container(
                              padding: const EdgeInsets.only(
                                right: 30,
                                left: 18,
                                top: 5,
                              ),
                              child: LineChart(
                                mainData(
                                  bottomTitleWidgets,
                                  leftTitleWidgets,
                                  lineBarsData(),
                                  getDrawingHorizontalLine,
                                  selectedList[0],
                                  80.0,
                                  220.0,
                                ),
                                swapAnimationCurve: Curves.fastOutSlowIn,
                                swapAnimationDuration:
                                    const Duration(seconds: 1),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: kBorderRadiusM,
                  boxShadow: [
                    BoxShadow(
                      color: kGrey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Center(child: Text("지금 상태는?")),
              ),
              const SizedBox(height: 20),
              Container(
                height: 400,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: kBorderRadiusM,
                  boxShadow: [
                    BoxShadow(
                      color: kGrey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Center(child: Text("변화 추이")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(color: kBlack.withOpacity(0.8), fontSize: 13);
    String text;

    DateTime now = DateTime.now();
    if (selectedList[0]) {
      switch (value.toInt()) {
        case 1:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 6)));
          break;
        case 2:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 5)));
          break;
        case 3:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 4)));
          break;
        case 4:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 3)));
          break;
        case 5:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 2)));
          break;
        case 6:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 1)));
          break;
        case 7:
          text = DateFormat('M/d').format(now);
          style = TextStyle(color: kMain, fontSize: 13);
          break;
        default:
          return Container();
      }
    } else {
      switch (value.toInt()) {
        case 1:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 28)));
          break;
        case 2:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 21)));
          break;
        case 3:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 14)));
          break;
        case 4:
          text =
              DateFormat('M/d').format(now.subtract(const Duration(days: 7)));
          break;
        case 5:
          text = DateFormat('M/d').format(now);
          style = TextStyle(color: kMain, fontSize: 13);
          break;
        default:
          return Container();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
        color: kBlack.withOpacity(0.6),
        fontSize: 13,
        fontFamily: 'PretendardL');
    var style2 =
        TextStyle(color: kGrey, fontSize: 12, fontFamily: 'PretendardL');
    String text;
    switch (value.toInt()) {
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;
      case 140:
        text = '140';
        break;
      case 180:
        text = '180';
        break;
      case 125:
        return Text("당뇨", style: style2, textAlign: TextAlign.left);
      case 200:
        return Text("당뇨", style: style2, textAlign: TextAlign.left);
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  List<LineChartBarData> lineBarsData() {
    return [
      lineChartBarData(
        selectedList[0]
            ? [
                FlSpot(1, beforeWeeklyList[6]),
                FlSpot(2, beforeWeeklyList[5]),
                FlSpot(3, beforeWeeklyList[4]),
                FlSpot(4, beforeWeeklyList[3]),
                FlSpot(5, beforeWeeklyList[2]),
                FlSpot(6, beforeWeeklyList[1]),
                FlSpot(7, beforeWeeklyList[0]),
              ]
            : [
                FlSpot(1.5, beforeMonthlyList[3]),
                FlSpot(2.5, beforeMonthlyList[2]),
                FlSpot(3.5, beforeMonthlyList[1]),
                FlSpot(4.5, beforeMonthlyList[0]),
              ],
        kDanger,
      ),
      lineChartBarData(
        selectedList[0]
            ? [
                FlSpot(1, afterWeeklyList[6]),
                FlSpot(2, afterWeeklyList[5]),
                FlSpot(3, afterWeeklyList[4]),
                FlSpot(4, afterWeeklyList[3]),
                FlSpot(5, afterWeeklyList[2]),
                FlSpot(6, afterWeeklyList[1]),
                FlSpot(7, afterWeeklyList[0]),
              ]
            : [
                FlSpot(1.5, afterMonthlyList[3]),
                FlSpot(2.5, afterMonthlyList[2]),
                FlSpot(3.5, afterMonthlyList[1]),
                FlSpot(4.5, afterMonthlyList[0]),
              ],
        kBS.withRed(255),
      ),
    ];
  }

  FlLine getDrawingHorizontalLine(value) {
    if (value == 80 || value == 100 || value == 140 || value == 180) {
      return FlLine(color: kLightGrey, strokeWidth: 0.6, dashArray: [4, 5]);
    } else if (value == 125) {
      return FlLine(color: kGrey, strokeWidth: 1, dashArray: [4, 5]);
    } else if (value == 200) {
      return FlLine(color: kGrey, strokeWidth: 1, dashArray: [4, 5]);
    }
    return FlLine(color: Colors.transparent);
  }
}
