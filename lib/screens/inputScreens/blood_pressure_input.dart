import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

class BloodPressureInputScreen extends StatefulWidget {
  const BloodPressureInputScreen({Key? key}) : super(key: key);

  @override
  State<BloodPressureInputScreen> createState() =>
      _BloodPressureInputScreenState();
}

class _BloodPressureInputScreenState extends State<BloodPressureInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("혈압 입력하기", context, hasBack: true),
    );
  }
}
