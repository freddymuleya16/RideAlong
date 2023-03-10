import 'package:flutter/cupertino.dart';

import 'package:ride_along/models/user/user-email.dart';

class EditProfileController {
  String userName = "";
  String userEmail = "";
  String userAge = "";

  bool validationEmail = true;

  updateUserName({required String name}) {
    userName = name;
  }

  updateUserEmail({required String email}) {
    userEmail = email;
  }

  updateUserAge({required String age}) {
    userAge = age;
  }

  updateValidations({
    required bool newValidationEmail,
  }) {
    validationEmail = newValidationEmail;
    print(validationEmail);
  }

  resetState() {
    userName = "";
    userEmail = "";
    userAge = "";
    validationEmail = true;
  }
}
