import 'package:flutter/material.dart';
import 'package:senior_health_care/screens/resultScreens/blood_pressure_result.dart';
import 'package:senior_health_care/screens/resultScreens/blood_sugar_result.dart';
import 'package:senior_health_care/screens/resultScreens/heart_rate_result.dart';
import 'package:senior_health_care/screens/resultScreens/weight_result.dart';
import 'package:share_plus/share_plus.dart';

import '../constants.dart';

class MainBoard extends StatefulWidget {
  const MainBoard({Key? key}) : super(key: key);

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Widget stateBox(desc, val, screen) {
      late Color color;

      if (val > 80) {
        color = kDanger;
      } else if (val > 40) {
        color = kWarning;
      } else {
        color = kSafe;
      }

      return Expanded(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: kBorderRadiusM,
            highlightColor: kLightGrey.withOpacity(0.4),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen));
            },
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: kBorderRadiusM,
              ),
              child: Row(
                children: [
                  Text("$desc일 확률",
                      style: TextStyle(color: kBlack, fontSize: kM)),
                  const Spacer(),
                  Text(
                    "$val%",
                    style: TextStyle(
                        fontSize: 42, fontFamily: 'PretendardB', color: color),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                "나의\n건강 상태는?",
                style: TextStyle(
                  fontFamily: 'PretendardB',
                  fontSize: 24,
                  color: kBlack,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Share.share("공유할 파일");
              },
              constraints: const BoxConstraints(),
              icon: Icon(Icons.share_rounded, size: 18, color: kMain),
            ),
          ],
        ),
        stateBox("고혈압", 86, const BloodPressureResultScreen()),
        const SizedBox(height: 8),
        stateBox("당뇨", 35, const BloodSugarResultScreen()),
        const SizedBox(height: 8),
        stateBox("비만", 74, const WeightResultScreen()),
        const SizedBox(height: 8),
        stateBox("심장 이상", 43, const HeartRateResultScreen()),
      ],
    );
  }
}
