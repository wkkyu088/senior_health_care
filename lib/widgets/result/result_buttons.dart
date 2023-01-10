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
            color: kGrey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 20,
        height: 160,
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
    ),
  );
}
