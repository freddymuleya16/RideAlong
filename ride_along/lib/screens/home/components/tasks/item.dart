//import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/task-colors.dart';
import 'package:ride_along/controllers/main-controller.dart';
import 'package:ride_along/models/tasks.dart';

class TasksItem extends StatefulWidget {
  final int index;
  TasksItem({required this.index});
  @override
  _TasksItemState createState() => _TasksItemState();
}

class _TasksItemState extends State<TasksItem> {
  late SlidableController slidableController;
  SlidableState? slidableState;
  late bool _delete;
  late double _opacity;

  void handleSlideAnimationChanged(Animation<double>? slideAnimation) {
    setState(() {});
  }

  void handleSlideIsOpenChanged(bool? isOpen) {
    setState(() {
      _delete = isOpen ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _delete = false;
    _opacity = 0;
    slidableState = Slidable.of(context);
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    _animationController();
  }

  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = brightnessValue == Brightness.dark;
    MainController _ = MainController();
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Slidable(
            controller: slidableController,
            dismissal: SlidableDismissal(
              child: SlidableDrawerDismissal(
                key: Key(_.tasks[widget.index][0]),
              ),
              // ignore: missing_return
              onWillDismiss: (actionType) async {
                print('object');
                await _removeTask();
                return true;
              },
            ),
            key: Key("${_.tasks[widget.index][0]}${widget.index}"),
            actionPane: const SlidableBehindActionPane(),
            actionExtentRatio: 1,
            secondaryActions: <Widget>[deleteBox()],
            actions: <Widget>[deleteBox()],
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              margin: const EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 0.001,
                    )
                  ],
                  color: _isDark ? kTextColorDark : kTextColorLight),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        activeColor: Colors.grey,
                        //inactiveColor:
                        //    colors[int.parse(_.tasks[widget.index][1])],
                        checkColor: kTextColorLight,
                        value: _.tasks[widget.index][2] == 'done',
                        onChanged: (value) {
                          //updateTask(index: widget.index);
                        },
                      ),
                    ),
                  ),
                  Text(
                    _.tasks[widget.index][0],
                    style: GoogleFonts.ubuntu(
                      color: _.tasks[widget.index][2] == 'done'
                          ? Colors.grey
                          : _isDark
                              ? kTextColorLight
                              : Colors.amberAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.5,
                      decoration: _.tasks[widget.index][2] == 'done'
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget deleteBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: _isDark ? kBackgroundColorDark : kBackgroundColor),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.5, right: 5),
          child: Icon(
            FontAwesomeIcons.trashAlt,
            color: _isDark ? kTextColorLight : Colors.grey,
            size: 22.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 10),
          child: Text(
            'The task was deleted',
            style: GoogleFonts.ubuntu(
              color: _isDark ? kTextColorLight : Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 17.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: 70,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: kBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.75),
                    blurRadius: 1,
                  )
                ]),
            child: Center(
              child: InkWell(
                onTap: () {
                  Slidable.of(context)!.close();
                },
                child: Text(
                  'UNDO',
                  style: GoogleFonts.ubuntu(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  _animationController() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    await Future.delayed(Duration(
        milliseconds: 500 * (MainController().tasks.length - widget.index)));
    setState(() {
      _opacity = 1;
    });
  }

  _removeTask() async {
    setState(() {
      _delete = true;
    });
    await Future.delayed(const Duration(milliseconds: 3500));
    if (_delete) {
      setState(() {
        _delete = false;
      });
      //removeTask(index: widget.index);
    }
    return null;
  }
}
