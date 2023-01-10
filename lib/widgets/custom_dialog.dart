import 'package:flutter/material.dart';
import 'package:senior_health_care/main.dart';
import 'package:senior_health_care/screens/input_screen.dart';
import '../constants.dart';

// 단순 확인용으로 쓸 수 있는 버튼 1개 모달
void oneButtonDialog(context, content, {title = "잠시만요!"}) {
  final screenWidth = MediaQuery.of(context).size.width;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          contentPadding: const EdgeInsets.only(top: 20),
          insetPadding: EdgeInsets.zero,
          backgroundColor: kWhite,
          content: SizedBox(
            width: screenWidth * 0.7,
            height: 200,
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: kL, color: kMain),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: kS + 1,
                        height: 1.4,
                        color: kBlack,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    primary: kWhite,
                    backgroundColor: kMain,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child:
                      Text("확인", style: TextStyle(color: kWhite, fontSize: kM)),
                ),
              ],
            ),
          ),
        );
      });
}

// 확인 혹은 취소 중 선택할 수 있는 버튼 2개 모달
void twoButtonDialog(context, content, onPressed,
    {isDelete = false, title = "잠시만요!", oneMorePop = false}) {
  final screenWidth = MediaQuery.of(context).size.width;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          contentPadding: const EdgeInsets.only(top: 20),
          backgroundColor: kWhite,
          content: SizedBox(
            width: screenWidth * 0.7,
            height: 200,
            child: Column(
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: kL, color: isDelete ? Colors.red : kMain)),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: kS + 1,
                        height: 1.4,
                        color: kBlack,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          if (oneMorePop) {
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kGrey,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10)),
                          ),
                          child: Text("취소",
                              style: TextStyle(color: kWhite, fontSize: kM)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: onPressed,
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isDelete ? Colors.red : kMain,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Text("확인",
                              style: TextStyle(color: kWhite, fontSize: kM)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

// 분석 결과를 띄우는 결과 팝업
void resultDialog(context, title, result, content, screen) {
  final screenWidth = MediaQuery.of(context).size.width;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          contentPadding: const EdgeInsets.only(top: 0),
          backgroundColor: kWhite,
          content: SizedBox(
            width: screenWidth * 0.7,
            height: 380,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 25),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: result == "safe"
                        ? kSafe
                        : result == "warn"
                            ? kWarning
                            : kDanger,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
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
                          fontSize: 30,
                          fontFamily: 'PretendardB',
                          color: kWhite),
                    ),
                  ]),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: kS + 1,
                        height: 1.4,
                        color: kBlack,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavBar(startIndex: 1)));
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kGrey,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10)),
                          ),
                          child: Text("처음으로",
                              style: TextStyle(color: kWhite, fontSize: kM)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => screen));
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kMain,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Text("전체 결과 보기",
                              style: TextStyle(color: kWhite, fontSize: kM)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
