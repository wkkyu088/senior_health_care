import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

class BloodPressureResultScreen extends StatefulWidget {
  const BloodPressureResultScreen({Key? key}) : super(key: key);

  @override
  State<BloodPressureResultScreen> createState() =>
      _BloodPressureResultScreenState();
}

class _BloodPressureResultScreenState extends State<BloodPressureResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("혈압 분석보기", context, hasBack: true),
    );
  }
}
