import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:senior_health_care/widgets/average_board.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';
import 'package:senior_health_care/widgets/main_board.dart';
import 'package:senior_health_care/widgets/recent_board.dart';

import '../constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIdx = 1;
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    var items = ["최근", "메인", "평균"].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: screenWidth,
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: kBorderRadiusM,
                boxShadow: [
                  BoxShadow(
                    color: kGrey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: i == "메인"
                  ? mainBoard(context)
                  : i == "최근"
                      ? recentBoard(context)
                      : i == "평균"
                          ? const AverageBoard()
                          : Container());
        },
      );
    }).toList();

    return Scaffold(
      appBar: customAppBar("메인", context, hasBack: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider(
            items: items,
            carouselController: controller,
            options: CarouselOptions(
                height: screenHeight * 0.7,
                viewportFraction: 0.85,
                initialPage: 1,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIdx = index;
                  });
                }),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: items.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => controller.animateToPage(entry.key),
                child: Container(
                  width: currentIdx == entry.key ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: kBorderRadiusM,
                      color: currentIdx == entry.key ? kMain : kLightGrey),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
