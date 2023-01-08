import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/result/common_chart_widget.dart';
import 'package:senior_health_care/widgets/result/result_toggle_buttons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants.dart';

class WeightResultScreen extends StatefulWidget {
  const WeightResultScreen({Key? key}) : super(key: key);

  @override
  State<WeightResultScreen> createState() => _WeightResultScreenState();
}

class _WeightResultScreenState extends State<WeightResultScreen> {
  List<bool> selectedList = [true, false];
  List<double> bmiWeeklyList = [25, 25, 25, 25, 25, 25, 25];
  List<double> bmiMonthlyList = [25, 25, 25, 25];

  _future() async {
    final users = FirebaseFirestore.instance.collection('users');
    DateTime now = DateTime.now();

    var v;
    for (var i = 0; i < 7; i++) {
      String date =
          DateFormat('yyyyMMdd').format(now.subtract(Duration(days: i)));
      var weights = await users.doc(uid).collection('weight').doc(date).get();

      // 만약 해당 날짜의 데이터가 없다면?
      if (weights.data() != null) {
        v = weights.data() as Map;

        bmiWeeklyList[i] = double.parse(v['bmi'].toString());

        print("$date $v");
      } else {
        bmiWeeklyList.add(-1);

        print("$date -1");
      }
    }
    print(bmiWeeklyList.toString());

    for (var i = 0; i < 4; i++) {
      double temp = 0;
      for (var j = 0; j < 7; j++) {
        String date = DateFormat('yyyyMMdd')
            .format(now.subtract(Duration(days: 7 * i + j)));
        var weights = await users.doc(uid).collection('weight').doc(date).get();

        // 만약 해당 날짜의 데이터가 없다면?
        if (weights.data() != null) {
          v = weights.data() as Map;

          temp += double.parse(v['bmi'].toString());

          print("${7 * i + j} $date $v");
        } else {
          bmiMonthlyList.add(-1);

          print("$date -1");
        }
      }
      print("temp $temp");
      bmiMonthlyList[i] = temp / 7;
    }
    print(bmiMonthlyList.toString());

    return v;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("몸무게 분석보기", context, hasBack: true),
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
                          chartLegend(Colors.red, "BMI"),
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
                                  15.0,
                                  38.0,
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
      case 20:
        text = '20';
        break;
      case 25:
        text = '25';
        break;
      case 35:
        text = '35';
        break;
      case 30:
        return Text("비만", style: style2, textAlign: TextAlign.left);
      case 18:
        return Text("저체중", style: style2, textAlign: TextAlign.left);
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
                FlSpot(1, bmiWeeklyList[6]),
                FlSpot(2, bmiWeeklyList[5]),
                FlSpot(3, bmiWeeklyList[4]),
                FlSpot(4, bmiWeeklyList[3]),
                FlSpot(5, bmiWeeklyList[2]),
                FlSpot(6, bmiWeeklyList[1]),
                FlSpot(7, bmiWeeklyList[0]),
              ]
            : [
                FlSpot(1.5, bmiMonthlyList[3]),
                FlSpot(2.5, bmiMonthlyList[2]),
                FlSpot(3.5, bmiMonthlyList[1]),
                FlSpot(4.5, bmiMonthlyList[0]),
              ],
        Colors.red,
      ),
    ];
  }

  FlLine getDrawingHorizontalLine(value) {
    if (value == 20 || value == 25 || value == 35) {
      return FlLine(color: kLightGrey, strokeWidth: 0.6, dashArray: [4, 5]);
    } else if (value == 30) {
      return FlLine(color: kGrey, strokeWidth: 1, dashArray: [4, 5]);
    } else if (value == 18) {
      return FlLine(color: kGrey, strokeWidth: 1, dashArray: [4, 5]);
    }
    return FlLine(color: Colors.transparent);
  }
}
