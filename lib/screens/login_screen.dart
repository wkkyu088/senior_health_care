// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:senior_health_care/screens/singup_screen.dart';

import 'package:senior_health_care/utils/auth.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isOpen = false;
  final emailCont = TextEditingController();
  final pwCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCont.clear();
    pwCont.clear();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: screenHeight - statusBarHeight - navigationBarHeight,
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 60),
          margin: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            children: [
              // 앱 로고
              SizedBox(
                height: isOpen ? screenHeight * 0.22 : screenHeight * 0.33,
                width: screenWidth * 0.4,
                child: Image.asset('assets/images/logo1.png'),
              ),
              // 이메일/비밀번호 입력 필드들
              Focus(
                onFocusChange: (focused) {
                  setState(() {
                    isOpen = focused ? true : false;
                  });
                },
                child: Column(
                  children: [
                    // 이메일 입력 필드
                    TextField(
                      controller: emailCont,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: kS),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail_rounded),
                        isCollapsed: true,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kMain, width: 1),
                          borderRadius: kBorderRadiusS,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGrey, width: 1),
                          borderRadius: kBorderRadiusS,
                        ),
                        hintText: '이메일',
                        hintStyle: TextStyle(fontSize: kS, color: kGrey),
                        counterText: '',
                      ),
                    ),
                    // 비밀번호 입력 필드
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
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
                            borderSide: BorderSide(color: kMain, width: 1),
                            borderRadius: kBorderRadiusS,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGrey, width: 1),
                            borderRadius: kBorderRadiusS,
                          ),
                          hintText: '비밀번호',
                          hintStyle: TextStyle(fontSize: kS, color: kGrey),
                          counterText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 로그인 버튼
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        MethodEmail.signInWithEmail(emailCont, pwCont, context);
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
                        children: [Text('로그인', style: TextStyle(fontSize: kM))],
                      ),
                    ),
                  ],
                ),
              ),
              isOpen
                  ? Container()
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: Text("또는",
                                    style:
                                        TextStyle(color: kGrey, fontSize: kXS)),
                              ),
                              // 구글 로그인 버튼
                              ListTile(
                                onTap: () {
                                  MethodGoogle.signInWithGoogle(context);
                                },
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: kLightGrey),
                                  borderRadius: kBorderRadiusS,
                                ),
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                                leading: SizedBox(
                                  height: kM,
                                  child: Image.asset(
                                      'assets/images/google_logo.png'),
                                ),
                                minLeadingWidth: 10,
                                title: Center(
                                  child: Text("구글로 시작하기",
                                      style: TextStyle(fontSize: kS)),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // 카카오 로그인 버튼
                              ListTile(
                                onTap: () {},
                                tileColor: const Color(0xFFFEE500),
                                shape: RoundedRectangleBorder(
                                  borderRadius: kBorderRadiusS,
                                ),
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                                leading: SizedBox(
                                  height: kS,
                                  child: Image.asset(
                                      'assets/images/kakao_logo.png'),
                                ),
                                minLeadingWidth: 10,
                                title: Center(
                                  child: Text("카카오로 시작하기",
                                      style: TextStyle(fontSize: kS)),
                                ),
                              ),
                            ],
                          ),
                          // 회원가입 버튼
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(
                                              isEmail: true,
                                              userId: "",
                                            )));
                              },
                              style: TextButton.styleFrom(primary: kGrey),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "처음이신가요? ",
                                    style: TextStyle(color: kBlack),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: kBlack),
                                      ),
                                    ),
                                    child: Text(
                                      "이메일로 회원가입하기",
                                      style: TextStyle(
                                        color: kBlack,
                                        fontFamily: 'PretendardB',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
