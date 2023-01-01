import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

class HeartRateResultScreen extends StatefulWidget {
  const HeartRateResultScreen({Key? key}) : super(key: key);

  @override
  State<HeartRateResultScreen> createState() => _HeartRateResultScreenState();
}

class _HeartRateResultScreenState extends State<HeartRateResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("심박수 분석보기", context, hasBack: true),
    );
  }
}
