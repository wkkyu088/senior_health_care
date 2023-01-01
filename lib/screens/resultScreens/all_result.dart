import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

class AllResultScreen extends StatefulWidget {
  const AllResultScreen({Key? key}) : super(key: key);

  @override
  State<AllResultScreen> createState() => _AllResultScreenState();
}

class _AllResultScreenState extends State<AllResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("전체 분석보기", context, hasBack: true),
    );
  }
}
