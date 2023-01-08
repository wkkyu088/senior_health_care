import 'package:flutter/material.dart';

import '../../constants.dart';

Widget description(desc) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Text(desc, style: TextStyle(fontSize: kS)),
  );
}

Widget customField(desc, cont, icon, suffix, hint, isEmpty) {
  return Column(
    children: [
      description(desc),
      SizedBox(
        width: 200,
        child: TextField(
          controller: cont,
          maxLines: 1,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: kS),
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            suffixText: suffix,
            suffixStyle: TextStyle(color: kBlack, fontSize: kS),
            isCollapsed: true,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kMain, width: 1),
              borderRadius: kBorderRadiusS,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: cont.text == ""
                      ? isEmpty
                          ? kDanger
                          : kGrey
                      : kGrey,
                  width: 1),
              borderRadius: kBorderRadiusS,
            ),
            hintText: hint,
            hintStyle: TextStyle(fontSize: kS, color: kGrey),
            counterText: '',
          ),
        ),
      ),
      cont.text == ""
          ? isEmpty
              ? Container(
                  width: 200,
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "필수 값입니다.",
                    style: TextStyle(color: kDanger, fontSize: kXS),
                  ),
                )
              : Container()
          : Container()
    ],
  );
}

Widget customMultiField(screenWidth, desc, cont, hint) {
  return Column(
    children: [
      description(desc),
      SizedBox(
        width: screenWidth - 100,
        child: TextField(
          controller: cont,
          maxLines: 5,
          maxLength: 100,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: kS),
          decoration: InputDecoration(
            isCollapsed: true,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kMain, width: 1),
              borderRadius: kBorderRadiusS,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kGrey, width: 1),
              borderRadius: kBorderRadiusS,
            ),
            hintText: hint,
            hintStyle: TextStyle(fontSize: kS, color: kGrey),
            counterStyle: TextStyle(fontSize: kXS - 2, color: kGrey),
          ),
        ),
      )
    ],
  );
}
