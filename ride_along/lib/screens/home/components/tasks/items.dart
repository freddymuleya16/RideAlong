import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//import 'package:circular_check_box/circular_check_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/controllers/main-controller.dart';
import 'package:ride_along/screens/Trip/controllers/create-trip-controller.dart';
import 'package:ride_along/screens/Trip/widgets/trip_tile.dart';
import 'package:ride_along/screens/home/animations.dart';
import 'package:ride_along/screens/home/components/tasks/item.dart';

import '../../../../models/trip.dart';

class HomeTasksItems extends StatefulWidget {
  @override
  _HomeTasksItemsState createState() => _HomeTasksItemsState();
}

class _HomeTasksItemsState extends State<HomeTasksItems> {
  bool _isDark = false;
  double notFoundOpacity = 0;
  List<Trip> trips = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      notFoundOpacity = 1;
    });
    TripController.getTripsByUserId(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      print({"jjj", value});
      setState(() {
        trips = value;
      });
    });
  }

  Future<void> _refreshList() async {
    // Perform your asynchronous refresh operation here
    await Future.delayed(Duration(seconds: 1));

    var value = await TripController.getTripsByUserId(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      trips = value;
    });
    print({"jjj", value});
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = brightnessValue == Brightness.dark;
    //HomeAnimationsController __ = HomeAnimationsController();
    //MainController _ = MainController();

    return RefreshIndicator(
      onRefresh: _refreshList,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 0),
        child: trips.isNotEmpty
            ? ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TripTile(
                      trip: trips[index],
                      from: trips[index].startLocation,
                      to: trips[index].endLocation,
                      depature: trips[index].startTime,
                      seats: trips[index].availableSeats,
                      price: trips[index].price,
                      duration: trips[index].duration,
                      isDark: _isDark,
                    ),
                  );
                },
              )
            : AnimatedOpacity(
                opacity: notFoundOpacity,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      "You have no upcoming trips",
                      style: GoogleFonts.ubuntu(
                          color: _isDark
                              ? kBackgroundColor.withOpacity(0.8)
                              : kSecondaryColor,
                          fontSize: 22.2,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: UnDraw(
                        height: MediaQuery.of(context).size.width - 100,
                        color: _isDark
                            ? kBackgroundColor.withOpacity(0.8)
                            : kSecondaryColor,
                        illustration: UnDrawIllustration.not_found,
                        placeholder: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: SpinKitDoubleBounce(
                            color: _isDark
                                ? kBackgroundColor.withOpacity(0.8)
                                : kSecondaryColor,
                            size: 75,
                          ),
                        ),
                        errorWidget: const Icon(Icons.error_outline,
                            color: Colors.red, size: 50),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
