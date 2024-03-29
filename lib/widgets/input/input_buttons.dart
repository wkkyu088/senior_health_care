import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants.dart';

Widget inputButton(icon, title, value, screen, color, context) {
  Map<dynamic, dynamic> data = {};

  _future() async {
    String date = DateFormat('yyyyMMdd').format(DateTime.now());

    var user = FirebaseFirestore.instance.collection('users').doc(uid);
    var v = await user.collection(value).doc(date).get();

    data = v.data() as Map;

    return v;
  }

  return FutureBuilder(
      future: _future(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
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
                color: color.withOpacity(0.6),
                borderRadius: kBorderRadiusM,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 115,
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
                      ],
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    child: LoadingAnimationWidget.waveDots(
                        color: kWhite, size: 25),
                  ),
                ],
              ),
            ),
          );
        }
        return InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
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
                color: data.isEmpty
                    ? kGrey.withOpacity(0.7)
                    : color.withOpacity(0.9),
                borderRadius: kBorderRadiusM,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 115,
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
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: data.isEmpty
                        ? Text(
                            "아직 기록이 없어요!",
                            style: TextStyle(
                              fontSize: kXS,
                              color: kWhite,
                            ),
                          )
                        : Icon(Icons.check, color: kWhite, size: 24),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
