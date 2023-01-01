// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class UserManager {
  // 유저 컬렉션
  static final users = FirebaseFirestore.instance.collection('users');

  // 유저 프로필 정보 설정하기
  static setProfile(userId, ageCont, isMale, heightCont) async {
    await users.doc(userId).set({
      'age': int.parse(ageCont.text),
      'gender': isMale,
      'height': double.parse(heightCont.text),
    });

    uid = userId;
    userAge = int.parse(ageCont.text);
    userGender = isMale;
    userHeight = double.parse(heightCont.text);

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
