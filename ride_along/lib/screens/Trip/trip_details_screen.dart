import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/controllers/user-controller.dart';
import 'package:ride_along/global-widgets/layout.dart';

import "package:intl/intl.dart" show DateFormat;
import 'package:ride_along/models/user/user.dart';
import 'package:ride_along/screens/Trip/utils/detailsUtils.dart';
import 'package:ride_along/screens/Trip/widgets/user_tile.dart';
import 'package:ride_along/screens/home/components/tasks/item.dart';
import '../../constants/colors.dart';
import '../../models/trip.dart';
import '../login/widgets/login_button.dart';
import 'widgets/floating-button.dart';

class TripDetailsScreen extends StatefulWidget {
  final Trip trip;

  TripDetailsScreen({required this.trip});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  bool _isDark = false;
  AppUser? driver;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserController.getUser(widget.trip.driverId).then((value) {
      setState(() {
        driver = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _isDark = isDark(context);
    return Layout(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trip Details',
                      style: GoogleFonts.ubuntu(
                        color: _isDark ? kBackgroundColor : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'From: ${widget.trip.startLocation}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'To: ${widget.trip.endLocation}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Departure Time: ${DateFormat("HH'h'mm d MMM y", 'en_US').format(widget.trip.startTime)}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Duration: ${widget.trip.duration}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: R${widget.trip.price.toStringAsFixed(2)}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Available seats: ${widget.trip.availableSeats}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Driver Details',
                      style: GoogleFonts.ubuntu(
                        color: _isDark ? kBackgroundColor : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/default_profile.png'),
                      // NetworkImage(trip.driver.photoUrl),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${driver?.firstname} ${driver?.lastname}',
                      style: GoogleFonts.ubuntu(
                        color: _isDark ? kBackgroundColor : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Car Details',
                      style: GoogleFonts.ubuntu(
                        color: _isDark ? kBackgroundColor : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Make: ${widget.trip.car.make}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Model: ${widget.trip.car.model}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Color: ${widget.trip.car.color}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Number plate: ${widget.trip.car.licensePlate}',
                      style: GoogleFonts.ubuntu(
                          color: _isDark ? kBackgroundColor : Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Requests',
                      style: GoogleFonts.ubuntu(
                        color: _isDark ? kBackgroundColor : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.trip.requestedPassengerIds.length,
                      itemBuilder: (context, index) => UserTile(
                          onWillDismiss: (actionType) async {
                            if (SlideActionType.primary == actionType) {
                              await DetailsUtils.rejectRequestedPassenger(
                                  widget.trip.id,
                                  widget.trip.requestedPassengerIds[index]);
                            }
                            if (SlideActionType.secondary == actionType) {
                              await DetailsUtils.addRequestedPassenger(
                                  widget.trip.id,
                                  widget.trip.requestedPassengerIds[index]);
                            }
                            setState(() {
                              widget.trip.requestedPassengerIds.remove(
                                  widget.trip.requestedPassengerIds[index]);
                            });
                            return true;
                          },
                          tripId: widget.trip.id,
                          uid: widget.trip.requestedPassengerIds[index]),
                    ),
                    const SizedBox(height: 16),
                    FirebaseAuth.instance.currentUser!.uid !=
                            widget.trip.driverId
                        ? LoginButton(
                            title: "Request a ride",
                            btnController: DetailsUtils.btn,
                            isDark: _isDark,
                            onPressed: () {
                              DetailsUtils.onPressed(
                                  context,
                                  FirebaseAuth.instance.currentUser!.uid,
                                  widget.trip.id);
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
