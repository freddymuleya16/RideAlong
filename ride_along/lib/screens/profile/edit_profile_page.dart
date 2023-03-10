import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/controllers/user-controller.dart';
import 'package:ride_along/global-widgets/layout.dart';
import 'package:ride_along/models/user/user.dart';
import 'package:ride_along/screens/login/widgets/login_button.dart';
import 'package:ride_along/screens/profile/utils/edit_profile_utils.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'widgets/appbar_widget.dart';
import 'widgets/button_widget.dart';
import 'widgets/profile.dart';
import 'widgets/textfield.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
          isEdit: true,
          onClicked: () async {},
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: TextFieldWidget(
            label: 'First Name',
            text: user!.firstname,
            onChanged: (name) {
              user!.firstname = name;
            },
          ),
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Last Name',
          text: user!.lastname,
          onChanged: (name) {
            user!.lastname = name;
          },
        ),
        const SizedBox(height: 24),
        // TextFieldWidget(
        //   label: 'Email',
        //   text: user!.email,
        //   onChanged: (email) {},
        // ),
        // const SizedBox(height: 24),
        TextFieldWidget(
          label: 'About',
          text: user!.about,
          maxLines: 5,
          onChanged: (about) {
            setState(() {
              user!.setAbout(about);
            });
            print({"about2", user!.about});
          },
        ),
        const SizedBox(height: 10),
        LoginButton(
          isDark: _isDark,
          title: "Update",
          btnController: EditProfileUtils.btn,
          onPressed: () {
            EditProfileUtils.updateProfile(user!).then((value) => {
                  if (value)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile updated'))),
                      Navigator.pop(context),
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Failed to update profile try again')))
                    }
                });
          },
        )
      ],
    );
  }
}
