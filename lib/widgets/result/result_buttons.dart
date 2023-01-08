import 'package:flutter/material.dart';

import '../../constants.dart';

Widget resultButton(icon, title, screen, color, context) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    },
    borderRadius: kBorderRadiusM,
    child: Container(
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
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2 - 30,
            height: 190,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: kBorderRadiusM,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 50),
                const SizedBox(height: 10),
                Text(title, style: TextStyle(fontSize: kM - 1, color: color)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
