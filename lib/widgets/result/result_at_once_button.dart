import 'package:flutter/material.dart';
import 'package:senior_health_care/screens/resultScreens/all_result.dart';

import '../../constants.dart';

Widget getAllResultButton(context) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AllResultScreen()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: kBorderRadiusM,
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 12,
          ),
        ],
        // gradient: const LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [Colors.blue, Colors.cyan],
        // ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.article_rounded, color: kMain, size: 30),
          const SizedBox(width: 10),
          Text("전체 분석 보기", style: TextStyle(fontSize: kM, color: kMain)),
        ],
      ),
    ),
  );
}
