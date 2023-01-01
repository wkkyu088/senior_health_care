import 'package:flutter/material.dart';
import '../constants.dart';

void showWarningDialog(context, content, {hasCancel = false}) {
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Icon(Icons.warning_rounded, color: kWarning, size: 40),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  "잠시만요!",
                  style: TextStyle(
                      color: kWarning, fontSize: kM, fontFamily: 'PretendardB'),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: TextStyle(fontSize: kS, height: 1.2),
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
                      width: MediaQuery.of(context).size.width * 0.7 / 2,
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

      // return AlertDialog(
      //   shape: RoundedRectangleBorder(borderRadius: kBorderRadiusS),
      //   actionsAlignment: MainAxisAlignment.spaceEvenly,
      //   contentPadding: const EdgeInsets.only(top: 40, bottom: 30),
      //   actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //   // 다이얼로그 제목
      //   title: Center(
      //       child: Text(title, style: TextStyle(color: kBlack, fontSize: kS))),
      //   // 다이얼로그 본문
      //   content: Text(
      //     content,
      //     style: TextStyle(color: kBlack, fontSize: kM),
      //     textAlign: TextAlign.center,
      //   ),
      //   // 하단 버튼 (취소 버튼이 필요하다면 hasCancel을 true로 설정)
      //   actions: hasCancel
      //       ? [
      //           Column(
      //             children: [
      //               TextButton(
      //                 onPressed: onPressed,
      //                 style: TextButton.styleFrom(
      //                   primary: kWhite,
      //                   backgroundColor: kMain,
      //                   padding: const EdgeInsets.symmetric(vertical: 12),
      //                 ),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [Text("확인", style: TextStyle(fontSize: kS))],
      //                 ),
      //               ),
      //               TextButton(
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                 },
      //                 style: TextButton.styleFrom(
      //                   primary: kGrey,
      //                   backgroundColor: kWhite,
      //                   side: BorderSide(color: kGrey),
      //                   padding: const EdgeInsets.symmetric(vertical: 12),
      //                 ),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Text('취소', style: TextStyle(fontSize: kS)),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           )
      //         ]
      //       : [
      //           TextButton(
      //             onPressed: onPressed,
      //             style: TextButton.styleFrom(
      //               primary: kWhite,
      //               backgroundColor: kMain,
      //               padding: const EdgeInsets.symmetric(vertical: 12),
      //             ),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text("확인", style: TextStyle(fontSize: kS)),
      //               ],
      //             ),
      //           )
      //         ],
      // );
    },
  );
}
