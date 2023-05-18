//import 'package:circular_check_box/circular_check_box.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/constants/task-colors.dart';
import 'package:ride_along/controllers/main-controller.dart';
import 'package:ride_along/controllers/user-controller.dart';
import 'package:ride_along/models/tasks.dart';
import 'package:ride_along/models/user/user.dart';
import 'package:ride_along/screens/Trip/utils/detailsUtils.dart';

class UserTile extends StatefulWidget {
  final String uid;
  final String tripId;

  final FutureOr<bool> Function(SlideActionType?)? onWillDismiss;
  UserTile({required this.uid, required this.tripId, this.onWillDismiss});
  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  SlidableController? slidableController;
  SlidableState? slidableState;
  bool _reject = false;
  double _opacity = 0;
  AppUser? user;

  void handleSlideAnimationChanged(Animation<double>? slideAnimation) {
    setState(() {});
  }

  void handleSlideIsOpenChanged(bool? isOpen) {
    setState(() {
      _reject = isOpen ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _reject = false;
    _opacity = 0;
    slidableState = Slidable.of(context);
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    _animationController();
    UserController.getUser(widget.uid).then((value) {
      setState(() {
        user = value;
      });
    });
  }

  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    _isDark = isDark(context);
    if (user == null) {
      return Center(
        child: CircularProgressIndicator(
          color: _isDark ? kTextColorLight : kBackgroundColorDark,
        ),
      );
    }
    // MainController _ = MainController();
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Slidable(
            controller: slidableController,
            dismissal: SlidableDismissal(
                onWillDismiss: widget.onWillDismiss,
                child: SlidableDrawerDismissal(
                  key: Key(user!.id),
                )),
            key: Key(user!.id),
            actionPane: const SlidableBehindActionPane(),
            actionExtentRatio: 1,
            secondaryActions: <Widget>[accept()],
            actions: <Widget>[reject()],
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
                  color: _isDark ? kBackgroundColorDark : Colors.grey[300]),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Transform.scale(
                        scale: 1.2,
                        child: Icon(
                          Icons.person,
                          color: _isDark ? kTextColorLight : kPrimaryColor,
                        )),
                  ),
                  Text(
                    "${user!.firstname} ${user!.lastname}",
                    style: GoogleFonts.ubuntu(
                      color: _isDark ? kTextColorLight : kPrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.5,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget accept() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.green),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        const Padding(
          padding: EdgeInsets.only(left: 25, right: 5),
          child: Icon(
            FontAwesomeIcons.check,
            color: kTextColorLight,
            size: 22.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 25),
          child: Text(
            'Accept',
            style: GoogleFonts.ubuntu(
              color: kTextColorLight,
              fontWeight: FontWeight.w500,
              fontSize: 17.5,
            ),
          ),
        ),
      ]),
    );
  }

  Widget reject() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.red),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(left: 25, right: 5),
          child: Icon(
            FontAwesomeIcons.ban,
            color: kTextColorLight,
            size: 22.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 25),
          child: Text(
            'Reject',
            style: GoogleFonts.ubuntu(
              color: kTextColorLight,
              fontWeight: FontWeight.w500,
              fontSize: 17.5,
            ),
          ),
        ),
      ]),
    );
  }

  _animationController() async {
    await Future.delayed(const Duration(milliseconds: 0));
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _opacity = 1;
    });
  }
}
