import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/types.dart';
import 'package:ride_along/models/set-system-overlay-style.dart';
import 'package:ride_along/screens/home/animations.dart';
import 'package:ride_along/controllers/home/home-controller.dart';
import 'package:ride_along/screens/home/components/drawer/drawer.dart';
import 'package:ride_along/screens/home/components/floating-button.dart';
import 'package:ride_along/screens/home/components/navbar.dart';
import 'package:ride_along/screens/home/components/tasks/tasks.dart';
import 'package:ride_along/screens/home/components/title-text.dart';

import '../../global-states/drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final HomeController homeController = (HomeController());

  //final HomeAnimationsController homeAnimationsController =
  //   HomeAnimationsController();

  final int num = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final drawer = Provider.of<DrawerState>(context);

    bool isDark = false;
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    isDark = brightnessValue == Brightness.dark;
    isDark
        ? setSystemUIOverlayStyle(
            systemUIOverlayStyle: SystemUIOverlayStyle.BLUE_DARK)
        : setSystemUIOverlayStyle(
            systemUIOverlayStyle: SystemUIOverlayStyle.LIGHT);
    drawer.advancedDrawerController.addListener(() {
      drawer.changeDrawerStatus();
      if (drawer.drawerStatus == DrawerStatus.OPEN) {
        isDark
            ? setSystemUIOverlayStyle(
                systemUIOverlayStyle: SystemUIOverlayStyle.DARK)
            : setSystemUIOverlayStyle(
                systemUIOverlayStyle: SystemUIOverlayStyle.BLUE);
      } else if (drawer.drawerStatus == DrawerStatus.CLOSE) {
        isDark
            ? setSystemUIOverlayStyle(
                systemUIOverlayStyle: SystemUIOverlayStyle.BLUE_DARK)
            : setSystemUIOverlayStyle(
                systemUIOverlayStyle: SystemUIOverlayStyle.LIGHT);
      }
    });

    //HomeController _ = homeController;
    // startHomeAnimations(homeAnimationsController: homeAnimationsController);

    return AdvancedDrawer(
      backdropColor: isDark ? kDarkBackgroundColor : kSecondaryColor,
      controller: drawer.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openRatio: 0.66,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      drawer: HomeDrawer(),
      child: Scaffold(
        backgroundColor: isDark ? kDarkBackgroundColor2 : kBackgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [HomeNavbar(), HomeTitleText(), HomeTasks()],
          ),
        )),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 25),
            child: HomeFloatingButton()),
      ),
    );
  }
}
