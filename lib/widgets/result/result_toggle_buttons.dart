import 'package:flutter/material.dart';

import '../../constants.dart';

Widget resultToggleButtons(selectedList, onPressed) {
  return ToggleButtons(
    isSelected: selectedList,
    borderRadius: kBorderRadiusL,
    fillColor: kMain,
    selectedColor: kWhite,
    selectedBorderColor: kMain,
    color: kGrey,
    borderColor: kGrey,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    constraints: const BoxConstraints(),
    onPressed: onPressed,
    children: [
      Container(
        width: 100,
        height: 30,
        alignment: Alignment.center,
        child: Text("주간", style: TextStyle(fontSize: kXS)),
      ),
      Container(
        width: 100,
        height: 30,
        alignment: Alignment.center,
        child: Text("월간", style: TextStyle(fontSize: kXS)),
      )
    ],
  );
}
