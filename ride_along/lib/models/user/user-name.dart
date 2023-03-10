// import 'package:flutter/cupertino.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ride_along/controllers/main-controller.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// Future<bool> checkUserName() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool userNameStatus = prefs.getString('user-name') != null ? true : false;

//   bool? auth = FirebaseAuth.instance.isBlank;

//   //return true; // just for debuging
//   return (auth ?? false) && userNameStatus;
// }

// Future<bool> setUserName({required String userName}) async {
//   if (userName == null ||
//       userName == "" ||
//       userName == " " ||
//       userName == "  " ||
//       userName == "   ") {
//     return false;
//   }
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('user-name', userName);
//     getUserName();
//     return true;
//   } catch (e) {
//     return false;
//   }
// }

// Future<String?> getUserName() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? userName = prefs.getString('user-name');
//   MainController>().updateMainStete(newUserName: userName);

//   return userName;
// }
