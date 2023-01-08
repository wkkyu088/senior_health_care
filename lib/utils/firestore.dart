// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class UserManager {
  // 유저 컬렉션
  static final users = FirebaseFirestore.instance.collection('users');

  // 유저 프로필 정보 설정하기
  static setProfile(userId, age, isMale, height) async {
    await users.doc(userId).set({
      'age': age,
      'gender': isMale,
      'height': height,
    });

    uid = userId;
    userAge = age;
    userGender = isMale;
    userHeight = height;

    print(uid);
    print(userAge);
    print(userGender);
    print(userHeight);
  }

  // 유저 프로필 정보 가져오기
  static getProfile(userId) async {
    var user = await users.doc(userId).get();

    final v = user.data() as Map;
    uid = userId;
    userAge = v['age'];
    userGender = v['gender'];
    userHeight = double.parse(v['height'].toString());

    print(uid);
    print(userAge);
    print(userGender);
    print(userHeight);
  }
}

class InputManager {
  // 유저 컬렉션
  static final users = FirebaseFirestore.instance.collection('users');

  static setToday(userId, date) async {
    final bloodPressures = users.doc(userId).collection('bloodPressure');
    final bloodSugar = users.doc(userId).collection('bloodSugar');
    final weight = users.doc(userId).collection('weight');
    final heartRate = users.doc(userId).collection('heartRate');

    var bp = await bloodPressures.doc(date).get();
    var bs = await bloodSugar.doc(date).get();
    var w = await weight.doc(date).get();
    var hr = await heartRate.doc(date).get();

    if (bp.data() == null) {
      await bloodPressures.doc(date).set({});
    }
    if (bs.data() == null) {
      await bloodSugar.doc(date).set({});
    }
    if (w.data() == null) {
      await weight.doc(date).set({});
    }
    if (hr.data() == null) {
      await heartRate.doc(date).set({});
    }

    print("------------- $date : 오늘 날짜 데이터 있는지 검사");
  }

  // 혈압 입력하기
  static setBloodPressure(userId, date, part, sys, dia, pul) async {
    final bloodPressures = users.doc(userId).collection('bloodPressure');

    await bloodPressures.doc(date).set({
      'part': part,
      'SYS': sys,
      'DIA': dia,
      'PUL': pul,
    });

    print("------------- $date : 혈압 입력 ($part, $sys, $dia, $pul)");
  }

  // 혈당 가져오기
  static getBloodPressure(userId, date) async {
    var bloodPressures =
        await users.doc(userId).collection('bloodPressure').doc(date).get();

    final v = bloodPressures.data() as Map;

    return v;
  }

  // 혈당 입력하기
  static setBloodSugar(userId, date, term, before, after, memo) async {
    final bloodSugars = users.doc(userId).collection('bloodSugar');

    await bloodSugars.doc(date).set({
      'term': term,
      'before': before,
      'after': after,
      'memo': memo,
    });

    print("------------- $date : 혈당 입력 ($term, $before, $after, $memo)");
  }

  // 몸무게 입력하기
  static setWeight(userId, date, height, weight, bmi) async {
    final weights = users.doc(userId).collection('weight');

    await weights.doc(date).set({
      'height': height,
      'weight': weight,
      'bmi': bmi,
    });

    print("------------- $date : 몸무게 입력 ($height, $weight, $bmi)");
  }

  // 심박수 입력하기
  static setHeartRate(userId, date, term, value) async {
    final heartRates = users.doc(userId).collection('heartRate');

    await heartRates.doc(date).set({
      'term': term,
      'value': value,
    });

    print("------------- $date : 심박수 입력 ($term, $value)");
  }
}
