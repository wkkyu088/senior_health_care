import 'package:flutter/material.dart';
import 'package:senior_health_care/screens/inputScreens/blood_pressure_input.dart';
import 'package:senior_health_care/screens/inputScreens/blood_sugar_input.dart';
import 'package:senior_health_care/screens/inputScreens/heart_rate_input.dart';
import 'package:senior_health_care/screens/inputScreens/weight_input.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/input_at_once_button.dart';
import 'package:senior_health_care/widgets/input_buttons.dart';
import 'package:senior_health_care/widgets/input_date_bar.dart';

import '../constants.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    Map<String, dynamic> bloodPressure = {"SYS": 120, "DIA": 80, "PUL": 64};
    Map<String, dynamic> bloodSugar = {"term": 'before', 'value': 120};
    Map<String, dynamic> weight = {};
    Map<String, dynamic> heartRate = {"value": 80};

    return Scaffold(
      appBar: customAppBar("입력하기", context, hasBack: false),
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              children: [
                const InputDateBar(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    inputButton(
                      Icons.tire_repair_outlined,
                      "혈압 입력 하기",
                      bloodPressure,
                      const BloodPressureInputScreen(),
                      const Color(0xFF64B5F6),
                      context,
                    ),
                    const SizedBox(width: 10),
                    inputButton(
                      Icons.bloodtype_outlined,
                      "혈당 입력 하기",
                      bloodSugar,
                      const BloodSugarInputScreen(),
                      const Color(0xFFE57373),
                      context,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    inputButton(
                      Icons.monitor_weight_outlined,
                      "몸무게 입력 하기",
                      weight,
                      const WeightInputScreen(),
                      const Color(0xFFFFB74D),
                      context,
                    ),
                    const SizedBox(width: 10),
                    inputButton(
                      Icons.monitor_heart_outlined,
                      "심박수 입력 하기",
                      heartRate,
                      const HeartRateInputScreen(),
                      const Color(0xFF4DB6AC),
                      context,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 90,
            child: getAllButton(context),
          ),
        ],
      ),
    );
  }
}
