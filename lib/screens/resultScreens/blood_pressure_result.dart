import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/result/common_chart_widget.dart';
import 'package:senior_health_care/widgets/result/result_toggle_buttons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants.dart';

class BloodPressureResultScreen extends StatefulWidget {
  const BloodPressureResultScreen({Key? key}) : super(key: key);

  @override
  State<BloodPressureResultScreen> createState() =>
      _BloodPressureResultScreenState();
}

class _BloodPressureResultScreenState extends State<BloodPressureResultScreen> {
  List<bool> selectedList = [true, false];
  List<double> sysWeeklyList = [120, 120, 120, 120, 120, 120, 120];
  List<double> diaWeeklyList = [80, 80, 80, 80, 80, 80, 80];
  List<double> pulWeeklyList = [65, 65, 65, 65, 65, 65, 65];
  List<double> sysMonthlyList = [120, 120, 120, 120];
  List<double> diaMonthlyList = [80, 80, 80, 80];
  List<double> pulMonthlyList = [65, 65, 65, 65];

  _future() async {
    final users = FirebaseFirestore.instance.collection('users');
    DateTime now = DateTime.now();

    var v;
    for (var i = 0; i < 7; i++) {
      String date =
          DateFormat('yyyyMMdd').format(now.subtract(Duration(days: i)));
      var bloodPressures =
          await users.doc(uid).collection('bloodPressure').doc(date).get();

      // 만약 해당 날짜의 데이터가 없다면?
      if (bloodPressures.data() != null) {
        v = bloodPressures.data() as Map;

        sysWeeklyList[i] = double.parse(v['SYS'].toString());
        diaWeeklyList[i] = double.parse(v['DIA'].toString());
        pulWeeklyList[i] = double.parse(v['PUL'].toString());

        print("$date $v");
      } else {
        sysWeeklyList.add(-1);
        diaWeeklyList.add(-1);
        pulWeeklyList.add(-1);

        print("$date -1");
      }
    }
    print(sysWeeklyList.toString());
    print(diaWeeklyList.toString());
    print(pulWeeklyList.toString());

    for (var i = 0; i < 4; i++) {
      double temp1 = 0;
      double temp2 = 0;
      double temp3 = 0;
      for (var j = 0; j < 7; j++) {
        String date = DateFormat('yyyyMMdd')
            .format(now.subtract(Duration(days: 7 * i + j)));
        var bloodPressures =
            await users.doc(uid).collection('bloodPressure').doc(date).get();

        // 만약 해당 날짜의 데이터가 없다면?
        if (bloodPressures.data() != null) {
          v = bloodPressures.data() as Map;

          temp1 += double.parse(v['SYS'].toString());
          temp2 += double.parse(v['DIA'].toString());
          temp3 += double.parse(v['PUL'].toString());

          print("${7 * i + j} $date $v");
        } else {
          sysMonthlyList.add(-1);
          diaMonthlyList.add(-1);
          pulMonthlyList.add(-1);

          print("$date -1");
        }
      }
      print("temp1 $temp1 temp2 $temp2 temp3 $temp3");
      sysMonthlyList[i] = temp1 / 7;
      diaMonthlyList[i] = temp2 / 7;
      pulMonthlyList[i] = temp3 / 7;
    }
    print(sysMonthlyList.toString());
    print(diaMonthlyList.toString());
    print(pulMonthlyList.toString());

    return v;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("혈압 분석보기", context, hasBack: true),
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
                          chartLegend(Colors.red, "수축기 혈압 (SYS)"),
                          const SizedBox(width: 10),
                          chartLegend(Colors.orange, "이완기 혈압 (DIA)"),
                          const SizedBox(width: 10),
                          chartLegend(Colors.lightGreen, "분당 맥박수 (PUL)"),
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
                          return Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
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
                                      50.0,
                                      170.0,
                                    ),
                                    swapAnimationCurve: Curves.fastOutSlowIn,
                                    swapAnimationDuration:
                                        const Duration(seconds: 1),
                                  ),
                                ),
                              ),
                            ],
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
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 120:
        text = '120';
        break;
      case 160:
        text = '160';
        break;
      case 90:
        return Text("저혈압", style: style2, textAlign: TextAlign.left);
      case 130:
        return Text("고혈압", style: style2, textAlign: TextAlign.left);
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
                FlSpot(1, sysWeeklyList[6]),
                FlSpot(2, sysWeeklyList[5]),
                FlSpot(3, sysWeeklyList[4]),
                FlSpot(4, sysWeeklyList[3]),
                FlSpot(5, sysWeeklyList[2]),
                FlSpot(6, sysWeeklyList[1]),
                FlSpot(7, sysWeeklyList[0]),
              ]
            : [
                FlSpot(1.5, sysMonthlyList[3]),
                FlSpot(2.5, sysMonthlyList[2]),
                FlSpot(3.5, sysMonthlyList[1]),
                FlSpot(4.5, sysMonthlyList[0]),
              ],
        Colors.red,
      ),
      lineChartBarData(
        selectedList[0]
            ? [
                FlSpot(1, diaWeeklyList[6]),
                FlSpot(2, diaWeeklyList[5]),
                FlSpot(3, diaWeeklyList[4]),
                FlSpot(4, diaWeeklyList[3]),
                FlSpot(5, diaWeeklyList[2]),
                FlSpot(6, diaWeeklyList[1]),
                FlSpot(7, diaWeeklyList[0]),
              ]
            : [
                FlSpot(1.5, diaMonthlyList[3]),
                FlSpot(2.5, diaMonthlyList[2]),
                FlSpot(3.5, diaMonthlyList[1]),
                FlSpot(4.5, diaMonthlyList[0]),
              ],
        Colors.orange,
      ),
      lineChartBarData(
        selectedList[0]
            ? [
                FlSpot(1, pulWeeklyList[6]),
                FlSpot(2, pulWeeklyList[5]),
                FlSpot(3, pulWeeklyList[4]),
                FlSpot(4, pulWeeklyList[3]),
                FlSpot(5, pulWeeklyList[2]),
                FlSpot(6, pulWeeklyList[1]),
                FlSpot(7, pulWeeklyList[0]),
              ]
            : [
                FlSpot(1.5, pulMonthlyList[3]),
                FlSpot(2.5, pulMonthlyList[2]),
                FlSpot(3.5, pulMonthlyList[1]),
                FlSpot(4.5, pulMonthlyList[0]),
              ],
        Colors.lightGreen,
      ),
    ];
  }

  FlLine getDrawingHorizontalLine(value) {
    if (value == 60 || value == 80 || value == 120 || value == 160) {
      return FlLine(color: kLightGrey, strokeWidth: 0.6, dashArray: [4, 5]);
    } else if (value == 130) {
      return FlLine(color: kGrey, strokeWidth: 1, dashArray: [4, 5]);
    } else if (value == 90) {
      return FlLine(color: kGrey, strokeWidth: 1, dashArray: [4, 5]);
    }
    return FlLine(color: Colors.transparent);
  }
}
