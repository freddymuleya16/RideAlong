import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_along/models/user/user.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfileUtils {
  static RoundedLoadingButtonController btn = RoundedLoadingButtonController();
  static Future<bool> updateProfile(AppUser user) async {
    try {
      print({"about", user.about});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .update(user.toFirebase());

      await FirebaseAuth.instance.currentUser!
          .updateDisplayName('${user.firstname} ${user.lastname}');
      Timer(const Duration(seconds: 2), () {
        btn.success();
        Timer(const Duration(seconds: 2), () {
          btn.reset();
        });
      });
      return true;
    } catch (e) {
      print(e);
      Timer(const Duration(seconds: 2), () {
        btn.error();
        Timer(const Duration(seconds: 2), () {
          btn.reset();
        });
      });
      return false;
    }
  }
}
