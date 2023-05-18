import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/controllers/home/drawer/edit-profile-controller.dart';
import 'package:ride_along/models/user/user.dart';

class EditProfileDialog extends StatelessWidget {
  EditProfileController editProfileController = (EditProfileController());
  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = brightnessValue == Brightness.dark;
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        EditProfileController _ = EditProfileController();

        return AlertDialog(
          backgroundColor: _isDark ? kBackgroundColorDark : kBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Edit profile",
            style: GoogleFonts.ubuntu(
                fontSize: 22.5,
                fontWeight: FontWeight.w600,
                color: _isDark ? kBackgroundColor : kBackgroundColorDark),
          ),
          content: Container(
            height: 220,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextField(
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _isDark
                          ? kBackgroundColor.withOpacity(0.8)
                          : kBackgroundColorDark.withOpacity(0.8)),
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan, width: 2),
                    ),
                    hintText: "Firstname",
                    hintStyle: GoogleFonts.ubuntu(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                        color: _isDark
                            ? kBackgroundColor.withOpacity(0.8)
                            : kBackgroundColorDark.withOpacity(0.8)),
                  ),
                  onChanged: (value) {
                    //EditProfileController().updateUserName(name: value);
                  }),
              const SizedBox(
                height: 15,
              ),
              TextField(
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _isDark
                          ? kBackgroundColor.withOpacity(0.8)
                          : kBackgroundColorDark.withOpacity(0.8)),
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan, width: 2),
                    ),
                    hintText: "Last name",
                    hintStyle: GoogleFonts.ubuntu(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                        color: _isDark
                            ? kBackgroundColor.withOpacity(0.8)
                            : kBackgroundColorDark.withOpacity(0.8)),
                  ),
                  onChanged: (value) {
                    //EditProfileController().updateUserName(name: value);
                  }),
              const SizedBox(
                height: 15,
              ),
              TextField(
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final _reg = RegExp(r'^\d+$');

                      return _reg.hasMatch(newValue.text) ? newValue : oldValue;
                    })
                  ],
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _isDark
                          ? kBackgroundColor.withOpacity(0.8)
                          : kBackgroundColorDark.withOpacity(0.8)),
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan, width: 2),
                    ),
                    hintText: "Age",
                    hintStyle: GoogleFonts.ubuntu(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                        color: _isDark
                            ? kBackgroundColor.withOpacity(0.8)
                            : kBackgroundColorDark.withOpacity(0.8)),
                  ),
                  onChanged: (value) {
                    EditProfileController().updateUserAge(age: value);
                  }),
              const SizedBox(
                height: 15,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _isDark
                          ? kBackgroundColor.withOpacity(0.8)
                          : kBackgroundColorDark.withOpacity(0.8)),
                  decoration: InputDecoration(
                    errorText: _.validationEmail
                        ? null
                        : "Email address is not correct.",
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan, width: 2),
                    ),
                    hintText: _.userEmail != "" ? _.userEmail : "Email",
                    hintStyle: GoogleFonts.ubuntu(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                        color: _isDark
                            ? kBackgroundColor.withOpacity(0.8)
                            : kBackgroundColorDark.withOpacity(0.8)),
                  ),
                  onChanged: (text) {
                    EditProfileController().updateUserEmail(email: text);
                  }),
            ]),
          ),
          actions: [
            TextButton(
              child: Text(
                "Discard",
                style: GoogleFonts.ubuntu(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent),
              ),
              onPressed: () {
                EditProfileController().resetState();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                "Save",
                style: GoogleFonts.ubuntu(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isDark
                        ? kBackgroundColor.withOpacity(0.9)
                        : kBackgroundColorDark),
              ),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
