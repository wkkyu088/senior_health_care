import 'package:flutter/material.dart';
import 'package:senior_health_care/widgets/radar_chart.dart';
import 'package:share_plus/share_plus.dart';

import '../constants.dart';

class AverageBoard extends StatefulWidget {
  const AverageBoard({Key? key}) : super(key: key);

  @override
  State<AverageBoard> createState() => _AverageBoardState();
}

class _AverageBoardState extends State<AverageBoard> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    DataColumn column(t) {
      return DataColumn(
          label: Expanded(
        child: Text(t, textAlign: TextAlign.center),
      ));
    }

    DataCell cellPlain(t) {
      return DataCell(Center(child: Text("$t")));
    }

    DataCell cellValue(t, color) {
      return DataCell(
          Center(child: Text("$t", style: TextStyle(color: color))));
    }

    DataCell cellDiff(v, t, color) {
      return DataCell(Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontFamily: 'PretendardM',
            ),
            children: [
              v != null
                  ? TextSpan(text: v ? "▲" : "▼")
                  : const TextSpan(text: "-"),
              TextSpan(text: " $t", style: TextStyle(fontSize: kXS)),
            ],
          ),
        ),
      ));
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
                "${userAge ~/ 10 * 10}대 ${userGender ? "남성" : "여성"} 평균",
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
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20),
            child: const CustomRadarChart(),
          ),
        ),
        DataTable(
          headingTextStyle:
              TextStyle(fontSize: 10, color: kGrey, fontFamily: 'PretendardM'),
          dataTextStyle:
              TextStyle(fontSize: 12, color: kBlack, fontFamily: 'PretendardM'),
          headingRowHeight: 12,
          dataRowHeight: 30,
          dividerThickness: 0,
          border: TableBorder(
            verticalInside: BorderSide(color: kLightGrey, width: 0.5),
            horizontalInside: BorderSide(color: kWhite, width: 0),
          ),
          columnSpacing: 35,
          horizontalMargin: 0,
          columns: [
            column(""),
            column("평균 값"),
            column("내 값"),
            column(""),
          ],
          rows: [
            DataRow(
              cells: [
                cellPlain("혈압 (SYS)"),
                cellPlain(120),
                cellValue(142, kDanger),
                cellDiff(true, 22, kDanger),
              ],
            ),
            DataRow(
              cells: [
                cellPlain("혈압 (DIA)"),
                cellPlain(86),
                cellValue(92, kDanger),
                cellDiff(true, 6, kDanger),
              ],
            ),
            DataRow(
              cells: [
                cellPlain("식전 혈당"),
                cellPlain(96),
                cellValue(87, kSafe),
                cellDiff(false, 9, kSafe),
              ],
            ),
            DataRow(
              cells: [
                cellPlain("식후 혈당"),
                cellPlain(162),
                cellValue(138, kSafe),
                cellDiff(false, 24, kSafe),
              ],
            ),
            DataRow(
              cells: [
                cellPlain("BMI"),
                cellPlain(23.9),
                cellValue(26.4, kDanger),
                cellDiff(true, 2.5, kDanger),
              ],
            ),
            DataRow(
              cells: [
                cellPlain("심박수"),
                cellPlain(68),
                cellValue(68, kBlack),
                cellDiff(null, 0, kGrey),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
