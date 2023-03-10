import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/models/tasks.dart';
import 'package:ride_along/screens/home/animations.dart';
import 'package:ride_along/screens/home/components/tasks/items.dart';

class HomeTasks extends StatefulWidget {
  @override
  State<HomeTasks> createState() => _HomeTasksState();
}

class _HomeTasksState extends State<HomeTasks> {
  Duration _animationDuration = Duration(milliseconds: 500);

  bool _isDark = false;
  double tasksTitleOpacity = 0;
  double notFoundOpacity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tasksTitleOpacity = 1;
      notFoundOpacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = brightnessValue == Brightness.dark;
    //HomeAnimationsController _ = HomeAnimationsController();
    return Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: AnimatedOpacity(
                  duration: _animationDuration,
                  opacity: tasksTitleOpacity,
                  child: Text(
                    "UPCOMING TRIPS",
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: _isDark
                            ? kBackgroundColor.withOpacity(0.5)
                            : Colors.black.withOpacity(0.3)),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 25.0),
              //   child: AnimatedOpacity(
              //       duration: _animationDuration,
              //       opacity: _.tasksTitleOpacity,
              //       child: IconButton(
              //           icon: Icon(FontAwesomeIcons.checkDouble,
              //               size: 22.5,
              //               color: _isDark
              //                   ? kBackgroundColor.withOpacity(0.5)
              //                   : Colors.black.withOpacity(0.3)),
              //           onPressed: () async {
              //             await Future.delayed(Duration(milliseconds: 111));
              //             doneAllTasks();
              //           })),
              // ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          HomeTasksItems()
        ],
      ),
    );
  }
}
