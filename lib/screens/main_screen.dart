import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:senior_health_care/widgets/custom_appbar.dart';

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

    mainBoard() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Text(
                  "나의\n건강 상태는?",
                  style: TextStyle(
                    fontFamily: 'PretendardB',
                    fontSize: 26,
                    color: kBlack,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'PretendardB',
                        fontSize: 48,
                        color: kSafe,
                        height: 0.6,
                      ),
                      children: const [
                        TextSpan(text: "92"),
                        TextSpan(text: "점", style: TextStyle(fontSize: 30)),
                      ]),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: screenWidth,
              // height: 80,
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: kBorderRadiusS),
              child: Center(child: Text("혈압")),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              width: screenWidth,
              // height: 80,
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: kBorderRadiusS),
              child: Center(child: Text("혈당")),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              width: screenWidth,
              // height: 80,
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: kBorderRadiusS),
              child: Center(child: Text("몸무게")),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              width: screenWidth,
              // height: 80,
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: kBorderRadiusS),
              child: Center(child: Text("심박수")),
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    }

    recentBoard() {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text(
              "점수 변화",
              style: TextStyle(
                fontFamily: 'PretendardB',
                fontSize: 26,
                color: kBlack,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: kBorderRadiusS),
              child: Center(child: Text("전체")),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kLightGrey, borderRadius: kBorderRadiusS),
                    child: Center(child: Text("혈압")),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kLightGrey, borderRadius: kBorderRadiusS),
                    child: Center(child: Text("혈당")),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kLightGrey, borderRadius: kBorderRadiusS),
                    child: Center(child: Text("몸무게")),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kLightGrey, borderRadius: kBorderRadiusS),
                    child: Center(child: Text("심박수")),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    }

    averageBoard() {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text(
              "60대 여성 평균",
              style: TextStyle(
                fontFamily: 'PretendardB',
                fontSize: 26,
                color: kBlack,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: kLightGrey, borderRadius: kBorderRadiusS),
              child: Text("Radar Chart"),
            ),
          ),
          DataTable(
            headingTextStyle: TextStyle(
                fontSize: 12, color: kGrey, fontFamily: 'PretendardM'),
            dataTextStyle: TextStyle(
                fontSize: 13, color: kBlack, fontFamily: 'PretendardM'),
            headingRowHeight: 30,
            dataRowHeight: 48,
            dividerThickness: 0,
            border: TableBorder.all(color: kWhite, width: 0),
            columnSpacing: 35,
            horizontalMargin: 0,
            columns: const [
              DataColumn(label: Expanded(child: Text(""))),
              DataColumn(
                  label: Expanded(
                      child: Text("평균 값", textAlign: TextAlign.center))),
              DataColumn(
                  label: Expanded(
                      child: Text("내 값", textAlign: TextAlign.center))),
              DataColumn(label: Expanded(child: Text(""))),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Center(child: Text('혈압'))),
                  DataCell(Center(child: Text("120/86"))),
                  DataCell(Center(
                      child: Text("140/76", style: TextStyle(color: kDanger)))),
                  DataCell(
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 10,
                            color: kDanger,
                            fontFamily: 'PretendardM',
                          ),
                          children: const [
                            TextSpan(text: "▲"),
                            TextSpan(
                                text: " 20", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Center(child: Text('혈당'))),
                  DataCell(Center(child: Text("110"))),
                  DataCell(Center(
                      child: Text("96", style: TextStyle(color: kSafe)))),
                  DataCell(
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 10,
                            color: kSafe,
                            fontFamily: 'PretendardM',
                          ),
                          children: const [
                            TextSpan(text: "▼"),
                            TextSpan(
                                text: " 14", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Center(child: Text('몸무게'))),
                  DataCell(Center(child: Text("65.4"))),
                  DataCell(Center(
                      child: Text("68.4", style: TextStyle(color: kDanger)))),
                  DataCell(
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 10,
                            color: kDanger,
                            fontFamily: 'PretendardM',
                          ),
                          children: const [
                            TextSpan(text: "▲"),
                            TextSpan(
                                text: " 3.0", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Center(child: Text('심박수'))),
                  DataCell(Center(child: Text("68"))),
                  DataCell(Center(child: Text("68"))),
                  DataCell(
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 10,
                            color: kGrey,
                            fontFamily: 'PretendardM',
                          ),
                          children: const [
                            TextSpan(text: "-"),
                            TextSpan(
                                text: " 0", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    var items = ["그래프", "메인", "평균"].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: screenWidth,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              padding: const EdgeInsets.all(20),
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
              ),
              child: i == "메인"
                  ? mainBoard()
                  : i == "그래프"
                      ? recentBoard()
                      : i == "평균"
                          ? averageBoard()
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
                viewportFraction: 0.8,
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
                  width: currentIdx == entry.key ? 25 : 10,
                  height: 10,
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
