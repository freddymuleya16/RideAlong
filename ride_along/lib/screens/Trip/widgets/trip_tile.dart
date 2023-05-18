import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:intl/intl.dart" show DateFormat;
import 'package:ride_along/screens/Trip/trip_details_screen.dart';

import '../../../constants/colors.dart';
import '../../../models/trip.dart';

class TripTile extends StatelessWidget {
  final bool isDark;
  final String from;
  final String to;
  final DateTime depature;
  final int seats;
  final double price;
  final String duration;

  final Trip trip;
  const TripTile(
      {super.key,
      required this.from,
      required this.to,
      required this.depature,
      required this.seats,
      required this.price,
      required this.duration,
      required this.isDark,
      required this.trip});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => TripDetailsScreen(trip: trip))),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            border: const Border.symmetric(),
                            color: isDark ? kAccentColor1 : kAccentColor3,
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 15, 25, 0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        DateFormat('jm').format(depature),
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 14,
                                          color: isDark
                                              ? kTextColorLight
                                              : kTextColorDark,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.drive_eta,
                                      color: isDark
                                          ? kTextColorLight
                                          : kTextColorDark,
                                    ),
                                    Expanded(
                                      child: Text(
                                        DateFormat('d/MM/y').format(depature),
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 14,
                                          color: isDark
                                              ? kTextColorLight
                                              : kTextColorDark,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 36,
                                    width: 18,
                                    child: Container(
                                        decoration: BoxDecoration(
                                      border: const Border.symmetric(
                                          horizontal: BorderSide.none,
                                          vertical: BorderSide.none),
                                      color: isDark
                                          ? kBackgroundColorDark
                                          : kBackgroundColor,
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(100),
                                          topRight: Radius.circular(100)),
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                        Text(
                                          from,
                                          textAlign: TextAlign.right,
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 14,
                                            color: isDark
                                                ? kTextColorLight
                                                    .withOpacity(0.6)
                                                : kTextColorDark,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ])),
                                  Text(
                                    '$duration',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 13,
                                      color: isDark
                                          ? kTextColorLight
                                          : kTextColorDark,
                                    ),
                                  ),
                                  Expanded(
                                      child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.end,
                                          alignment: WrapAlignment.end,
                                          children: [
                                        Text(
                                          to,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 14,
                                            color: isDark
                                                ? kTextColorLight
                                                    .withOpacity(0.6)
                                                : kTextColorDark,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ])),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 36,
                                    width: 18,
                                    child: Container(
                                        decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 20, color: Colors.white),
                                      color: isDark
                                          ? kBackgroundColorDark
                                          : kBackgroundColor,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(100),
                                          topLeft: Radius.circular(100)),
                                    )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 0, 25, 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Seats: $seats',
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 14,
                                          color: isDark
                                              ? kTextColorLight
                                              : kTextColorDark,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'R${price.toStringAsFixed(2)}',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 14,
                                          color: isDark
                                              ? kTextColorLight
                                              : kTextColorDark,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ))),
        ),
      ],
    );
  }
}
