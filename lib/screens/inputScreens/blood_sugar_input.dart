import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

class BloodSugarInputScreen extends StatefulWidget {
  const BloodSugarInputScreen({Key? key}) : super(key: key);

  @override
  State<BloodSugarInputScreen> createState() => _BloodSugarInputScreenState();
}

class _BloodSugarInputScreenState extends State<BloodSugarInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("혈당 입력하기", context, hasBack: true),
    );
  }
}
