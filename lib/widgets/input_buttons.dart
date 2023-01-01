import 'package:flutter/material.dart';

import '../constants.dart';

Widget inputButton(icon, title, Map value, screen, color1, context) {
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: value.isEmpty
                  ? kGrey.withOpacity(0.7)
                  : color1.withOpacity(0.9),
              borderRadius: kBorderRadiusM,
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: kWhite, size: 50),
                      const SizedBox(height: 5),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: kM - 1,
                          color: kWhite,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: value.isEmpty
                      ? Text(
                          "아직 기록이 없어요!",
                          style: TextStyle(
                            fontSize: kXS,
                            color: kWhite,
                          ),
                        )
                      : Icon(Icons.check, color: kWhite, size: 24),
                ),
                // : Text(value.values.toString(),
                //     style: TextStyle(fontSize: kXS, color: kWhite)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
