import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class InputDateBar extends StatefulWidget {
  const InputDateBar({Key? key}) : super(key: key);

  @override
  State<InputDateBar> createState() => _InputDateBarState();
}

class _InputDateBarState extends State<InputDateBar> {
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: kBorderRadiusM,
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Material(
                borderRadius: kBorderRadiusL,
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: kBorderRadiusL,
                    onTap: () {
                      selected = selected.subtract(const Duration(days: 1));
                      setState(() {});
                      print("어제 날짜 $selected");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        color: kBlack,
                        size: 24,
                      ),
                    )),
              ),
              TextButton(
                onPressed: null,
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text("오늘",
                    style: TextStyle(color: kWhite, fontSize: kXS - 2)),
              ),
            ],
          ),
          Text(
            DateFormat('yyyy. MM. dd.').format(selected),
            style: TextStyle(color: kBlack, fontSize: kM),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  selected = DateTime.now();
                  setState(() {});
                  print("오늘로");
                },
                style: TextButton.styleFrom(
                  primary: kWhite,
                  backgroundColor: kMain,
                  side: BorderSide(color: kMain, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: kBorderRadiusS),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text("오늘", style: TextStyle(fontSize: kXS - 2)),
              ),
              Material(
                borderRadius: kBorderRadiusL,
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: kBorderRadiusL,
                    onTap: () {
                      selected = selected.add(const Duration(days: 1));
                      setState(() {});
                      print("내일 날짜 $selected");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: kBlack,
                        size: 24,
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
