import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:ride_along/global-widgets/navbar.dart';

import '../constants/colors.dart';
import '../constants/set-system-overlay-style.dart';
import '../constants/types.dart';
import '../global-states/drawer.dart';
import '../screens/home/components/drawer/drawer.dart';

class Layout extends StatefulWidget {
  final Widget? floatingActionButton;
  final List<Widget> children;
  const Layout({super.key, this.floatingActionButton, required this.children});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
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
            child: Column(
          children: [const Navbar(), ...widget.children],
        )),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 25),
            child: widget.floatingActionButton),
      ),
    );
  }
}
