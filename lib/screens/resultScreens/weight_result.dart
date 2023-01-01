import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

class WeightResultScreen extends StatefulWidget {
  const WeightResultScreen({Key? key}) : super(key: key);

  @override
  State<WeightResultScreen> createState() => _WeightResultScreenState();
}

class _WeightResultScreenState extends State<WeightResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("몸무게 분석보기", context, hasBack: true),
    );
  }
}
