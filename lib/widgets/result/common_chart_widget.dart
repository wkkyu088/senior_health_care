import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

Widget chartLegend(color, title) {
  return Row(
    children: [
      Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1.6),
          shape: BoxShape.circle,
        ),
      ),
      Text(title, style: TextStyle(fontSize: kXS)),
    ],
  );
}

FlDotPainter dotWidget(
    FlSpot spot, double xPercentage, LineChartBarData bar, int index) {
  return FlDotCirclePainter(
    radius: 3,
    color: kWhite,
    strokeColor: bar.color,
    strokeWidth: 2,
  );
}

List<TouchedSpotIndicatorData> touchedIndicators(
    LineChartBarData barData, List<int> indicators) {
  return indicators.map((int index) {
    final flLine = FlLine(color: barData.color, strokeWidth: 2.0);
    final dotData = FlDotData(
        getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
              radius: 4.5,
              color: bar.color,
              strokeColor: kWhite,
              strokeWidth: 2,
            ));

    return TouchedSpotIndicatorData(flLine, dotData);
  }).toList();
}

LineChartBarData lineChartBarData(spots, color) {
  return LineChartBarData(
    spots: spots,
    color: color,
    isCurved: true,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true, getDotPainter: dotWidget),
  );
}

LineChartData mainData(bottomTitleWidgets, leftTitleWidgets, lineBarsData,
    getDrawingHorizontalLine, isWeekly, minY, maxY) {
  return LineChartData(
    lineTouchData: LineTouchData(
      handleBuiltInTouches: true,
      getTouchedSpotIndicator: touchedIndicators,
      touchSpotThreshold: 50,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: kLightGrey.withOpacity(0.2),
        tooltipBorder: BorderSide(color: kLightGrey, width: 0.8),
        fitInsideHorizontally: true,
      ),
    ),
    gridData: FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: getDrawingHorizontalLine,
      getDrawingVerticalLine: (value) {
        return FlLine(color: kLightGrey);
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border(bottom: BorderSide(color: kLightGrey)),
    ),
    minX: 1,
    maxX: isWeekly ? 7 : 5,
    minY: minY,
    maxY: maxY,
    lineBarsData: lineBarsData,
  );
}
