import 'package:flutter/material.dart';
import 'package:senior_health_care/main.dart';
import 'package:senior_health_care/screens/input_screen.dart';
import '../constants.dart';

void showWarningDialog(context, content, {hasCancel = false, isCheck = false}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: kBorderRadiusM),
        contentPadding: const EdgeInsets.only(top: 10),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                alignment: Alignment.center,
                child: isCheck
                    ? Icon(Icons.check_box_rounded, color: kMain, size: 40)
                    : Icon(Icons.warning_rounded, color: kWarning, size: 40),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  isCheck ? "이 값이 맞나요?" : "잠시만요!",
                  style: TextStyle(
                    color: isCheck ? kMain : kWarning,
                    fontSize: kM,
                    fontFamily: 'PretendardB',
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: TextStyle(fontSize: kS, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  hasCancel
                      ? InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7 / 2,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: kLightGrey,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(18),
                              ),
                            ),
                            child: Text(
                              "취소",
                              style: TextStyle(color: kWhite),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: hasCancel
                          ? MediaQuery.of(context).size.width * 0.7 / 2
                          : MediaQuery.of(context).size.width * 0.7,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: kMain,
                        borderRadius: BorderRadius.only(
                            bottomLeft: hasCancel
                                ? const Radius.circular(0)
                                : const Radius.circular(18),
                            bottomRight: const Radius.circular(18)),
                      ),
                      child: Text(
                        "확인",
                        style: TextStyle(color: kWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showResultDialog(context, title, result, content, screen) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: kBorderRadiusM),
        contentPadding: const EdgeInsets.only(top: 0),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                decoration: BoxDecoration(
                  color: result == "safe"
                      ? kSafe
                      : result == "warn"
                          ? kWarning
                          : kDanger,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18)),
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      result == "safe"
                          ? Icons.check_circle_rounded
                          : result == "warn"
                              ? Icons.warning_rounded
                              : Icons.dangerous_rounded,
                      color: kWhite,
                      size: 90,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 30, fontFamily: 'PretendardB', color: kWhite),
                  ),
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: TextStyle(fontSize: kS, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BottomNavBar(startIndex: 1)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7 / 2,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                        ),
                      ),
                      child: Text(
                        "처음으로",
                        style: TextStyle(color: kWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => screen));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7 / 2,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: kMain,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(18)),
                      ),
                      child: Text(
                        "전체 결과 보기",
                        style: TextStyle(color: kWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
