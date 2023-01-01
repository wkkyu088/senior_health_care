import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

class WeightInputScreen extends StatefulWidget {
  const WeightInputScreen({Key? key}) : super(key: key);

  @override
  State<WeightInputScreen> createState() => _WeightInputScreenState();
}

class _WeightInputScreenState extends State<WeightInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("몸무게 입력하기", context, hasBack: true),
    );
  }
}
