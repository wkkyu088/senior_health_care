import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:senior_health_care/screens/input_screen.dart';
import 'package:senior_health_care/screens/login_screen.dart';
import 'package:senior_health_care/screens/main_screen.dart';
import 'package:senior_health_care/screens/result_screen.dart';
import 'package:senior_health_care/screens/setting_screen.dart';
import 'package:senior_health_care/screens/splash_screen.dart';

import './constants.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  // 파이어베이스 초기화
  await Firebase.initializeApp(
    name: 'senidoc',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 기본 상단바, 네비게이션바 색 맞추기
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kBackground,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: kBackground,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      // 기기의 폰트 크기 무시
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      // 디버그 배너 지우기
      debugShowCheckedModeBanner: false,
      // 기본 폰트, 색상 등 설정
      theme: ThemeData(
        scaffoldBackgroundColor: kBackground,
        fontFamily: 'PretendardM',
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: kMain,
          onPrimary: kMain,
          secondary: kGrey,
          onSecondary: kGrey,
          error: kMain,
          onError: kMain,
          background: kBackground,
          onBackground: kBackground,
          surface: kGrey,
          onSurface: kGrey,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kMain,
          selectionHandleColor: kMain,
          selectionColor: kMain.withOpacity(0.3),
        ),
      ),
      // 시작 화면
      home: const SplashScreen(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final int startIndex;
  const BottomNavBar({Key? key, required this.startIndex}) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // 시작 화면 인덱스
  int selectedIndex = 2;
  // bottomBar에 들어갈 화면 리스트
  final screens = [
    const ResultScreen(),
    const InputScreen(),
    const MainScreen(),
    const SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.startIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomNavBar() {
      return Container(
        height: 70,
        color: kBackground,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: kMain,
          unselectedItemColor: kGrey,
          iconSize: 22,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: '분석보기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_rounded),
              label: '입력하기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: '설정',
            ),
          ],
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kWhite,
        body: Stack(
          children: [
            screens[selectedIndex],
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: bottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
