import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';

class HomeDrawerItem extends StatelessWidget {
  String title;
  IconData icon;
  Function()? onTap;
  HomeDrawerItem({required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: kTextColorLight.withOpacity(0.3),
      child: Container(
          padding: const EdgeInsets.only(top: 12.5, bottom: 12.5, left: 40),
          child: Row(
            children: [
              Icon(
                icon,
                color: kTextColorLight.withOpacity(0.925),
                size: 17.5,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: GoogleFonts.ubuntu(
                  color: kTextColorLight.withOpacity(0.925),
                  fontWeight: FontWeight.w600,
                  fontSize: 17.5,
                ),
              ),
            ],
          )),
    );
  }
}
