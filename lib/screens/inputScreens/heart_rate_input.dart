import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

class HeartRateInputScreen extends StatefulWidget {
  const HeartRateInputScreen({Key? key}) : super(key: key);

  @override
  State<HeartRateInputScreen> createState() => _HeartRateInputScreenState();
}

class _HeartRateInputScreenState extends State<HeartRateInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("심박수 입력하기", context, hasBack: true),
    );
  }
}
