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
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: kBorderRadiusS,
                ),
              ),
              Container(
                width: screenWidth,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: kBorderRadiusS,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/img2.webp'),
                    fit: BoxFit.cover,
                    opacity: 0.8,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "내 주변 병원 정보",
                      style:
                          TextStyle(fontSize: kM, height: 1.5, color: kWhite),
                    ),
                    Text(
                      "한 눈에 보기",
                      style: TextStyle(
                          fontSize: kXL,
                          fontFamily: 'PretendardB',
                          color: kWhite),
                    ),
                  ],
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
                flex: 1,
                child: Container(
                    height: screenHeight,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: kBorderRadiusS,
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            kMain.withOpacity(0.8),
                            Colors.blue.withOpacity(0.5)
                          ]),
                    ),
                    child: Center(
                      child: Text(
                        "SeniDoc\n소식",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kWhite,
                          fontFamily: 'PretendardB',
                          fontSize: kS,
                        ),
                      ),
                    )),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      height: screenHeight,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: kBorderRadiusS,
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: kBorderRadiusS,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/img3.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.8,
                        ),
                      ),
                      child: Text(
                        "체지방의\n모든 것",
                        style: TextStyle(color: kWhite, fontSize: kS),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: kBorderRadiusS,
                ),
              ),
              Container(
                width: screenWidth,
                height: screenHeight,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: kBorderRadiusS,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/img1.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.6,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "당뇨병 예방에",
                      style: TextStyle(
                        color: kWhite,
                        fontSize: kL,
                        fontFamily: 'PretendardB',
                        height: 2,
                      ),
                    ),
                    Text(
                      "좋은음식은 무엇일까?",
                      style: TextStyle(color: kWhite, fontSize: kS),
                    ),
                  ],
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
