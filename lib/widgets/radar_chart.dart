import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

var fashionColor = kAVG;
var artColor = kMain;

class CustomRadarChart extends StatefulWidget {
  const CustomRadarChart({super.key});

  @override
  State<CustomRadarChart> createState() => _CustomRadarChartState();
}

class _CustomRadarChartState extends State<CustomRadarChart> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: RadarChart(
            RadarChartData(
              radarTouchData: RadarTouchData(
                touchCallback: (FlTouchEvent event, response) {
                  if (!event.isInterestedForInteractions) {
                    setState(() {
                      selectedDataSetIndex = -1;
                    });
                    return;
                  }
                  setState(() {
                    selectedDataSetIndex =
                        response?.touchedSpot?.touchedDataSetIndex ?? -1;
                  });
                },
              ),
              dataSets: showingDataSets(),
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(color: Colors.transparent),
              titlePositionPercentageOffset: 0.15,
              titleTextStyle: TextStyle(
                  color: kBlack.withOpacity(0.8),
                  fontSize: kXS,
                  fontFamily: 'PretendardM'),
              getTitle: (index, angle) {
                final usedAngle = angleValue;
                switch (index) {
                  case 0:
                    return RadarChartTitle(text: '혈압(SYS)', angle: usedAngle);
                  case 1:
                    return RadarChartTitle(text: '혈압(DIA)', angle: usedAngle);
                  case 2:
                    return RadarChartTitle(text: '식전 혈당', angle: usedAngle);
                  case 3:
                    return RadarChartTitle(text: '식후 혈당', angle: usedAngle);
                  case 4:
                    return RadarChartTitle(text: 'BMI', angle: usedAngle);
                  case 5:
                    return RadarChartTitle(text: '심박수', angle: usedAngle);
                  default:
                    return const RadarChartTitle(text: '');
                }
              },
              tickCount: 1,
              ticksTextStyle:
                  const TextStyle(color: Colors.transparent, fontSize: 10),
              tickBorderData: const BorderSide(color: Colors.transparent),
              gridBorderData:
                  BorderSide(color: kBlack.withOpacity(0.8), width: 1.5),
            ),
            swapAnimationDuration: const Duration(milliseconds: 200),
          ),
        ),
        SizedBox(
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rawDataSets()
                .asMap()
                .map((index, value) {
                  final isSelected = index == selectedDataSetIndex;
                  return MapEntry(
                    index,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDataSetIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(vertical: 1),
                        height: 22,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? kGrey.withOpacity(0.4)
                              : Colors.transparent,
                          borderRadius: kBorderRadiusM,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInToLinear,
                              padding: EdgeInsets.all(isSelected ? 6 : 5),
                              decoration: BoxDecoration(
                                color: value.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInToLinear,
                              style: TextStyle(
                                color: isSelected ? kBlack : kGrey,
                                fontFamily: 'PretendardM',
                                fontSize: kXS,
                              ),
                              child: Text(value.title),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                .values
                .toList(),
          ),
        ),
      ],
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.4)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2 : 1.7,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: '평균',
        color: fashionColor,
        values: [
          120,
          86,
          110,
          160,
          65.4,
          68,
        ],
      ),
      RawDataSet(
        title: '나',
        color: artColor,
        values: [
          140,
          76,
          106,
          180,
          68.4,
          68,
        ],
      ),
    ];
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
  final String title;
  final Color color;
  final List<double> values;
}
