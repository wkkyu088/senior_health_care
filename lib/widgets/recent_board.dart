import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../constants.dart';

class RecentBoard extends StatefulWidget {
  const RecentBoard({Key? key}) : super(key: key);

  @override
  State<RecentBoard> createState() => _RecentBoardState();
}

class _RecentBoardState extends State<RecentBoard> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                "건강 정보",
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
        Expanded(
          flex: 5,
          child: Container(
            width: screenWidth,
            decoration:
                BoxDecoration(color: kLightGrey, borderRadius: kBorderRadiusS),
            child: Center(child: Text("정보1")),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: kLightGrey, borderRadius: kBorderRadiusS),
                  child: Center(child: Text("정보2")),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: kLightGrey, borderRadius: kBorderRadiusS),
                  child: Center(child: Text("정보3")),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: kLightGrey, borderRadius: kBorderRadiusS),
                  child: Center(child: Text("정보4")),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: kLightGrey, borderRadius: kBorderRadiusS),
                  child: Center(child: Text("정보5")),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
