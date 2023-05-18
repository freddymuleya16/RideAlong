import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart'
    as mp;

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/controllers/home/drawer/edit-profile-controller.dart';
import 'package:ride_along/models/user/user.dart';
import 'package:ride_along/screens/Trip/find_trip_result.dart';

class FindTripDialog extends StatelessWidget {
  bool _isDark = false;

  String _destination = "";

  String _origin = "";
  String _destinationErr = "";

  String _originErr = "";

  @override
  Widget build(BuildContext context) {
    _isDark = isDark(context);
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return AlertDialog(
          backgroundColor: _isDark ? kBackgroundColorDark : kBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "FIND TRIP",
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
                    hintText: "Origin",
                    errorText: _originErr,
                    hintStyle: GoogleFonts.ubuntu(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                        color: _isDark
                            ? kBackgroundColor.withOpacity(0.8)
                            : kBackgroundColorDark.withOpacity(0.8)),
                  ),
                  onChanged: (value) {
                    _origin = value;
                  }),
              const SizedBox(
                height: 15,
              ),
              mp.MapBoxAutoCompleteWidget(
                apiKey:
                    "pk.eyJ1IjoiZnJlZGR5bXVsZXlhMTYiLCJhIjoiY2xlbGtqZTc5MHdiZTN3bXp3MmtmMzNxYSJ9.yYK05x2KDI_BOxzAm0WcvQ",
                hint: "Origin",
                language: 'en',
              ),
              mp.CustomTextField(hintText: "hintText"),
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
                    hintText: "Destination",
                    errorText: _destinationErr,
                    hintStyle: GoogleFonts.ubuntu(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                        color: _isDark
                            ? kBackgroundColor.withOpacity(0.8)
                            : kBackgroundColorDark.withOpacity(0.8)),
                  ),
                  onChanged: (value) {
                    _destination = value;
                  }),
              const SizedBox(
                height: 15,
              ),
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
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                "Search",
                style: GoogleFonts.ubuntu(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isDark
                        ? kBackgroundColor.withOpacity(0.9)
                        : kBackgroundColorDark),
              ),
              onPressed: () {
                _destinationErr = "";
                _originErr = "";
                if (_destination.isEmpty) {
                  setState(
                    () {
                      _destinationErr = "Destination is required";
                    },
                  );
                }

                if (_origin.isEmpty) {
                  setState(
                    () {
                      _originErr = "Origin is required";
                    },
                  );
                }
                if (_destinationErr.isNotEmpty || _originErr.isNotEmpty) {
                  return;
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => FindTripResult(
                            origin: _origin, destination: _destination)));
              },
            ),
          ],
        );
      },
    );
  }
}
