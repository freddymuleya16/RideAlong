import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/types.dart';
import 'package:ride_along/models/set-system-overlay-style.dart';
import 'package:ride_along/screens/home/animations.dart';
import 'package:ride_along/controllers/home/home-controller.dart';

import '../../../global-states/drawer.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar({super.key});
  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  Duration _animationSpeed = Duration(milliseconds: 300);

  bool _isDark = false;
  double navbarOpacity1 = 0, navbarOpacity2 = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      navbarOpacity1 = 1;
      navbarOpacity2 = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawer = Provider.of<DrawerState>(context);

    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = brightnessValue == Brightness.dark;
    //HomeAnimationsController _ = HomeAnimationsController();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedOpacity(
            duration: _animationSpeed,
            opacity: navbarOpacity1,
            child: IconButton(
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: drawer.advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: Icon(
                      value.visible
                          ? FontAwesomeIcons.times
                          : FontAwesomeIcons.stream,
                      color: _isDark
                          ? kBackgroundColor
                          : Colors.black.withOpacity(0.40),
                      size: 22.2,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
              onPressed: () {
                drawer.advancedDrawerController.showDrawer();
                _isDark
                    ? setSystemUIOverlayStyle(
                        systemUIOverlayStyle: SystemUIOverlayStyle.DARK)
                    : setSystemUIOverlayStyle(
                        systemUIOverlayStyle: SystemUIOverlayStyle.BLUE);
              },
            ),
          ),
          AnimatedOpacity(
            duration: _animationSpeed,
            opacity: navbarOpacity2,
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
                color:
                    _isDark ? kBackgroundColor : Colors.black.withOpacity(0.40),
                size: 22.2,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
