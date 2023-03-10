import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:ride_along/constants/types.dart';

class DrawerState with ChangeNotifier {
  AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();

  DrawerStatus drawerStatus = DrawerStatus.CLOSE;
  changeDrawerStatus() {
    drawerStatus = drawerStatus == DrawerStatus.CLOSE
        ? DrawerStatus.OPEN
        : DrawerStatus.CLOSE;

    notifyListeners();
  }
}

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
