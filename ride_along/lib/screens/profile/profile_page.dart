import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:ride_along/controllers/user-controller.dart';
import 'package:ride_along/global-widgets/layout.dart';
import 'package:ride_along/models/user/user.dart';

import '../../constants/colors.dart';
import '../../constants/is_dark.dart';
import 'edit_profile_page.dart';
import 'widgets/appbar_widget.dart';
import 'widgets/button_widget.dart';
import 'widgets/numbers.dart';
import 'widgets/profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AppUser? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserController.getUser(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = isDark(context);

    if (user == null) {
      return Center(
        child: CircularProgressIndicator(
          color: _isDark ? Colors.white : kSecondaryColor,
        ),
      );
    }
    return Layout(
      children: [
        ProfileWidget(
          imagePath: user!.imageUrl,
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditProfilePage()),
            );
          },
        ),
        const SizedBox(height: 24),
        buildName(user!),
        const SizedBox(height: 24),
        FirebaseAuth.instance.currentUser!.uid == user!.id
            ? const SizedBox()
            : Center(child: buildUpgradeButton()),
        const SizedBox(height: 24),
        NumbersWidget(
            numberOfTrips: user!.numberOfTrips,
            rating: user!.rating,
            totalDistance: user!.totalDistance),
        const SizedBox(height: 48),
        buildAbout(user!),
      ],
    );
  }

  Widget buildName(AppUser user) => Column(
        children: [
          Text(
            '${user.firstname} ${user.lastname}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Message',
        onClicked: () {},
      );

  Widget buildAbout(AppUser user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'About',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
