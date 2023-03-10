import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/routes.dart';
import 'package:ride_along/controllers/home/home-controller.dart';
import 'package:ride_along/models/tasks.dart';
import 'package:ride_along/screens/Trip/find_trip.dart';
import 'package:ride_along/screens/chat/messages_screen.dart';
import 'package:ride_along/screens/home/components/drawer/items/item.dart';
import 'package:ride_along/screens/home/components/drawer/items/edit-profile.dart';
import 'package:ride_along/screens/home/components/drawer/items/remove-all-tasks.dart';
import 'package:ride_along/screens/profile/profile_page.dart';

import '../../../../../global-states/drawer.dart';
import '../../../../Trip/create_new_trip_screen.dart';
//import 'package:url_launcher/url_launcher.dart';

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeDrawerItem(
            title: "Add new trip",
            icon: FontAwesomeIcons.circlePlus,
            onTap: () async {
              Provider.of<DrawerState>(context, listen: false)
                  .advancedDrawerController
                  .hideDrawer();
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        contentPadding: const EdgeInsets.all(0),
                        content: CreateNewTripPage(),
                      ));
            }),
        HomeDrawerItem(
            title: "Messages",
            icon: FontAwesomeIcons.message,
            onTap: () async {
              Provider.of<DrawerState>(context, listen: false)
                  .advancedDrawerController
                  .hideDrawer();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const MessagesScreen()));
              //HomeController().advancedDrawerController.hideDrawer();
              //await Future.delayed(const Duration(milliseconds: 450));
              //doneAllTasks();
            }),
        HomeDrawerItem(
            title: "Search trip",
            icon: FontAwesomeIcons.search,
            onTap: () async {
              Provider.of<DrawerState>(context, listen: false)
                  .advancedDrawerController
                  .hideDrawer();
              showDialog(
                context: context,
                builder: (context) {
                  return FindTripDialog();
                },
              );
            }),
        HomeDrawerItem(
            title: "Profile",
            icon: FontAwesomeIcons.person,
            onTap: () async {
              Provider.of<DrawerState>(context, listen: false)
                  .advancedDrawerController
                  .hideDrawer();
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => ProfilePage()));
              //HomeController().advancedDrawerController.hideDrawer();
              // await Future.delayed(const Duration(milliseconds: 420));
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return EditProfileDialog();
              //   },
              // );
            }),
        HomeDrawerItem(
            title: "Support",
            icon: FontAwesomeIcons.handHoldingHeart,
            onTap: () {
              _launchInBrowser('https://github.com/freddymuleya16/');
            }),
        HomeDrawerItem(
            title: "Log out",
            icon: FontAwesomeIcons.rightFromBracket,
            onTap: () {
              Provider.of<DrawerState>(context, listen: false)
                  .advancedDrawerController
                  .hideDrawer();
              FirebaseAuth.instance.signOut();
              // Navigator.pop(context);
            }),
      ],
    );
  }

  DrawerItem(String s, IconData checkDouble, Future<Null> Function() param2) {}
}

Future<void> _launchInBrowser(String url) async {
  try {
    // await launch(
    //   url,
    //   forceSafariVC: false,
    //   forceWebView: false,
    //   headers: <String, String{'my_header_key': 'my_header_value'},
    // );
  } catch (e) {
    throw 'Could not launch $url';
  }
}
