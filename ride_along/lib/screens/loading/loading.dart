import 'package:flutter/material.dart';
import 'package:ride_along/authentication/auth.dart';

import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/routes.dart';
import 'package:ride_along/controllers/main-controller.dart';
import 'package:ride_along/models/set-system-overlay-style.dart';
import 'package:ride_along/models/tasks.dart';
import 'package:ride_along/constants/types.dart';
import 'package:ride_along/models/user/user-email.dart';
import 'package:ride_along/models/user/user-name.dart';
import 'package:ride_along/screens/loading/animations.dart';
import 'package:ride_along/screens/loading/components/logo.dart';
import 'package:ride_along/screens/loading/components/spinkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ride_along/firebase_options.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LoadingAnimationsController loadingAnimationsController =
      LoadingAnimationsController();
  String nextRoute = home_route;
  bool isFirstEnter = false;
  bool _isDark = false;
  @override
  void initState() {
    super.initState();
    nextRoute = home_route;
    isFirstEnter = false;
    startLoadingAnimations();
    load();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = brightnessValue == Brightness.dark;
    _isDark
        ? setSystemUIOverlayStyle(
            systemUIOverlayStyle: SystemUIOverlayStyle.DARK)
        : setSystemUIOverlayStyle(
            systemUIOverlayStyle: SystemUIOverlayStyle.LIGHT);
    return Scaffold(
        backgroundColor: _isDark ? kDarkBackgroundColor : kBackgroundColor,
        body: Padding(
            padding: const EdgeInsets.only(left: 50, right: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(),
                LoadingLogo(
                  isDark: _isDark,
                ),
                SizedBox(),
                LoadingSpinkit(
                  isDark: _isDark,
                ),
              ],
            )));
  }

  load() async {
    // await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    //);

    await check();
    pass();
  }

  check() async {
    // await checkUserName().then((response) {
    //   MainController>().updateMainStete(
    //     newFirstEnterStatus: !response,
    //   );
    //   setState(() {
    //     isFirstEnter = !response;
    //     if (isFirstEnter) {
    //       nextRoute = welcome_route;
    //     } else {
    //       getTasks();
    //       getUserName().then((response) {
    //         MainController>().updateMainStete(
    //           newUserName: response,
    //         );
    //       });
    //       getUserEmail();

    //       nextRoute = home_route;
    //     }
    //   });
    // });
  }

  pass() async {
    if (mounted) {
      await Future.delayed(loadingAnimationsController.allAnimationTimes);
      print({1, "Passed"});
      //Navigator.push(context, MaterialPageRoute(builder: (builder) => Auth()));
    }
  }
}
