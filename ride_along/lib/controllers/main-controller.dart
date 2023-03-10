import 'package:flutter/material.dart';

class MainController {
  bool isFirstEnter = false;
  String userName = "";
  String userEmail = "";
  String userAge = "";

  List tasks = [
    ["fgfggfc", Colors.black.value.toString(), 0]
  ];

  updateMainStete(
      {bool? newFirstEnterStatus,
      String? newUserName,
      String? newUserEmail,
      String? newUserAge,
      List? newTasks}) {
    isFirstEnter = newFirstEnterStatus ?? isFirstEnter;
    userName = newUserName ?? userName;
    userEmail = newUserEmail ?? userEmail;
    userAge = newUserAge ?? userAge;
    tasks = newTasks ?? tasks;
  }
}
