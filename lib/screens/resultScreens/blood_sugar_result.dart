import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

class BloodSugarResultScreen extends StatefulWidget {
  const BloodSugarResultScreen({Key? key}) : super(key: key);

  @override
  State<BloodSugarResultScreen> createState() => _BloodSugarResultScreenState();
}

class _BloodSugarResultScreenState extends State<BloodSugarResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("혈당 분석보기", context, hasBack: true),
    );
  }
}
