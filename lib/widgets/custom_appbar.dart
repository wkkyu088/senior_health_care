import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

AppBar customAppBar(title, context, {hasBack = true}) {
  return AppBar(
    toolbarHeight: title == "메인" ? 75 : 60,
    title: title == "메인"
        ? SizedBox(
            height: 60,
            child: Image.asset('assets/images/logo1.png'),
          )
        : Text(title,
            style: TextStyle(
                color: kBlack, fontSize: kL, fontFamily: 'PretendardB')),
    leading: hasBack
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded, color: kBlack, size: 24))
        : Container(),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
  );
}
