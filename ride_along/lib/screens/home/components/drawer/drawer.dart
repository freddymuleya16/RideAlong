import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/controllers/main-controller.dart';
import 'package:ride_along/screens/home/components/drawer/items/items.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isDark = isDark(context);
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25, bottom: 25, left: 25),
              child: Icon(
                Icons.drive_eta,
                color: kTextColorLight,
                size: MediaQuery.of(context).size.width * 0.55,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child:
                      Text(FirebaseAuth.instance.currentUser?.displayName ?? "",
                          textScaleFactor: 0.8,
                          style: GoogleFonts.ubuntu(
                            color: kTextColorLight,
                            fontWeight: FontWeight.w800,
                            fontSize: 35,
                          )),
                ),
              ],
            ),
            Row(
              children: [
                // Padding(
                //   padding: EdgeInsets.only(left: 42.5, bottom: 25),
                //   child:
                //       Text(FirebaseAuth.instance.currentUser?.displayName ?? "",
                //           style: GoogleFonts.ubuntu(
                //             color: kTextColorLight.withOpacity(0.7),
                //             fontWeight: FontWeight.w700,
                //             fontSize: 12.5,
                //           )),
                // ),
              ],
            ),
            DrawerItems()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text("Copyright ©2023 | Freddy Muleya",
              style: GoogleFonts.ubuntu(
                  color: kTextColorLight,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    ));
  }
}
