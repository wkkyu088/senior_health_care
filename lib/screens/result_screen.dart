import 'package:flutter/material.dart';
import 'package:senior_health_care/screens/resultScreens/blood_pressure_result.dart';
import 'package:senior_health_care/screens/resultScreens/blood_sugar_result.dart';
import 'package:senior_health_care/screens/resultScreens/heart_rate_result.dart';
import 'package:senior_health_care/screens/resultScreens/weight_result.dart';
import 'package:senior_health_care/widgets/result_at_once_button.dart';
import 'package:senior_health_care/widgets/result_buttons.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

import '../constants.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("분석보기", context, hasBack: false),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          children: [
            getAllResultButton(context),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                resultButton(
                  Icons.tire_repair_outlined,
                  "혈압 분석 보기",
                  const BloodPressureResultScreen(),
                  const Color(0xFF64B5F6),
                  context,
                ),
                const SizedBox(width: 10),
                resultButton(
                  Icons.bloodtype_outlined,
                  "혈당 분석 보기",
                  const BloodSugarResultScreen(),
                  const Color(0xFFE57373),
                  context,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                resultButton(
                  Icons.monitor_weight_outlined,
                  "몸무게 분석 보기",
                  const WeightResultScreen(),
                  const Color(0xFFFFB74D),
                  context,
                ),
                const SizedBox(width: 10),
                resultButton(
                  Icons.monitor_heart_outlined,
                  "심박수 분석 보기",
                  const HeartRateResultScreen(),
                  const Color(0xFF4DB6AC),
                  context,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
