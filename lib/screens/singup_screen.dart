// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:senior_health_care/utils/auth.dart';
import 'package:senior_health_care/widgets/custom_dialog.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  final bool isEmail;
  final String userId;
  const SignUpScreen({Key? key, required this.isEmail, required this.userId})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailCont = TextEditingController();
  final pwCont = TextEditingController();
  final pwCheckCont = TextEditingController();
  final ageCont = TextEditingController();
  final heightCont = TextEditingController();
  bool isMale = true;
  bool isFemale = false;
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [isMale, isFemale];
    emailCont.clear();
    pwCont.clear();
    pwCheckCont.clear();
    ageCont.clear();
    heightCont.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight - statusBarHeight - navigationBarHeight,
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          margin: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            children: [
              // 앱 로고
              SizedBox(
                height:
                    widget.isEmail ? screenHeight * 0.22 : screenHeight * 0.3,
                width: screenWidth * 0.4,
                child: Image.asset('assets/images/logo1.png'),
              ),
              // 가입 정보 입력 필드들
              Column(
                children: [
                  // 이메일/비밀번호 입력
                  widget.isEmail
                      ? Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              child: Text(
                                "이메일/비밀번호",
                                style: TextStyle(color: kBlack, fontSize: kS),
                              ),
                            ),
                            // 이메일 입력 필드
                            TextField(
                              controller: emailCont,
                              maxLines: 1,
                              maxLength: 50,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(fontSize: kS),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.mail_rounded),
                                isCollapsed: true,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kMain, width: 1),
                                  borderRadius: kBorderRadiusS,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kGrey, width: 1),
                                  borderRadius: kBorderRadiusS,
                                ),
                                hintText: '이메일',
                                hintStyle:
                                    TextStyle(fontSize: kS, color: kGrey),
                                counterText: '',
                              ),
                            ),
                            // 비밀번호 입력 필드
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: pwCont,
                                maxLines: 1,
                                maxLength: 20,
                                obscureText: true,
                                style: TextStyle(fontSize: kS),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock_rounded),
                                  isCollapsed: true,
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kMain, width: 1),
                                    borderRadius: kBorderRadiusS,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kGrey, width: 1),
                                    borderRadius: kBorderRadiusS,
                                  ),
                                  hintText: '비밀번호',
                                  hintStyle:
                                      TextStyle(fontSize: kS, color: kGrey),
                                  counterText: '',
                                ),
                              ),
                            ),
                            // 비밀번호 확인 입력 필드
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextField(
                                controller: pwCheckCont,
                                maxLines: 1,
                                maxLength: 20,
                                obscureText: true,
                                style: TextStyle(fontSize: kS),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.check_rounded,
                                      color: pwCheckCont.text != ""
                                          ? pwCont.text == pwCheckCont.text
                                              ? kSafe
                                              : kDanger
                                          : null),
                                  isCollapsed: true,
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: pwCheckCont.text != ""
                                            ? pwCont.text == pwCheckCont.text
                                                ? kSafe
                                                : kDanger
                                            : kMain,
                                        width: 1),
                                    borderRadius: kBorderRadiusS,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: pwCheckCont.text != ""
                                          ? pwCont.text == pwCheckCont.text
                                              ? kSafe
                                              : kDanger
                                          : kGrey,
                                      width: 1,
                                    ),
                                    borderRadius: kBorderRadiusS,
                                  ),
                                  hintText: '비밀번호 확인',
                                  hintStyle:
                                      TextStyle(fontSize: kS, color: kGrey),
                                  counterText: '',
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  // 사용자 정보 입력
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: Text(
                          "사용자 정보",
                          style: TextStyle(color: kBlack, fontSize: kS),
                        ),
                      ),
                      // 성별 선택 필드
                      ToggleButtons(
                        isSelected: isSelected,
                        constraints: const BoxConstraints(),
                        onPressed: (value) {
                          if (value == 0) {
                            isMale = true;
                            isFemale = false;
                          } else {
                            isMale = false;
                            isFemale = true;
                          }
                          setState(() {
                            isSelected = [isMale, isFemale];
                          });
                        },
                        color: kGrey,
                        borderColor: kGrey,
                        selectedColor: kWhite,
                        selectedBorderColor: kMain,
                        fillColor: kMain,
                        textStyle:
                            TextStyle(fontSize: kS, fontFamily: 'PretendardM'),
                        borderRadius: kBorderRadiusS,
                        children: [
                          Container(
                            width: (screenWidth - 100) / 2 - 1.5,
                            height: 45,
                            alignment: Alignment.center,
                            child: const Text("남자"),
                          ),
                          Container(
                            width: (screenWidth - 100) / 2 - 1.5,
                            height: 45,
                            alignment: Alignment.center,
                            child: const Text("여자"),
                          ),
                        ],
                      ),
                      // 나이 입력 필드
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          controller: ageCont,
                          maxLines: 1,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: kS),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_rounded),
                            suffixText: "세",
                            suffixStyle: TextStyle(color: kBlack, fontSize: kS),
                            isCollapsed: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kMain, width: 1),
                              borderRadius: kBorderRadiusS,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGrey, width: 1),
                              borderRadius: kBorderRadiusS,
                            ),
                            hintText: '나이 (세)',
                            hintStyle: TextStyle(fontSize: kS, color: kGrey),
                            counterText: '',
                          ),
                        ),
                      ),
                      // 키 입력 필드
                      TextField(
                        controller: heightCont,
                        maxLines: 1,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: kS),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.straighten_rounded),
                          suffixText: "cm",
                          suffixStyle: TextStyle(color: kBlack, fontSize: kS),
                          isCollapsed: true,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kMain, width: 1),
                            borderRadius: kBorderRadiusS,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGrey, width: 1),
                            borderRadius: kBorderRadiusS,
                          ),
                          hintText: '키 (cm)',
                          hintStyle: TextStyle(fontSize: kS, color: kGrey),
                          counterText: '',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // 회원가입 버튼
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        String email = emailCont.text;
                        String pw = pwCont.text;
                        String pwCheck = pwCheckCont.text;
                        int age = int.parse(ageCont.text);
                        double height = double.parse(heightCont.text);

                        print(age);
                        print(height);
                        if (age < 1 || age > 120) {
                          showWarningDialog(
                              context, "나이 값이 범위 밖입니다.\n(1 ~ 120)");
                        } else if (height < 80.0 || height > 250.0) {
                          showWarningDialog(
                              context, "키 값이 범위 밖입니다.\n(80.0 ~ 250.0)");
                        } else {
                          if (widget.isEmail) {
                            // 이메일 가입이라면
                            if (pw != pwCheck) {
                              showWarningDialog(context, "비밀번호가 일치하지 않습니다.");
                            } else {
                              MethodEmail.signUpWithEmail(
                                  email, pw, age, isMale, height, context);
                            }
                          } else {
                            // 이메일 가입이 아니라면
                            MethodGoogle.signUpWithGoogle(
                                context, widget.userId, age, isMale, height);
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: kWhite,
                        backgroundColor: kMain,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: kBorderRadiusS),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('회원가입', style: TextStyle(fontSize: kM))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
