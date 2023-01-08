import 'package:flutter/material.dart';

import '../../constants.dart';

Widget getAllButton(context) {
  return InkWell(
    onTap: () {},
    child: Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 70,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: kMain,
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
          Icon(Icons.widgets_rounded, color: kWhite, size: 30),
          const SizedBox(width: 10),
          Text("한 번에 불러오기", style: TextStyle(fontSize: kM, color: kWhite)),
        ],
      ),
    ),
  );
}
