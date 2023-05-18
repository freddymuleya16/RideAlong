import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/global-widgets/layout.dart';
import 'package:ride_along/models/trip.dart';
import 'package:ride_along/screens/Trip/widgets/trip_tile.dart';

class FindTripResult extends StatefulWidget {
  final String origin;

  final String destination;

  const FindTripResult(
      {super.key, required this.origin, required this.destination});

  @override
  State<FindTripResult> createState() => _FindTripResultState();
}

class _FindTripResultState extends State<FindTripResult> {
  var _isDark = false;

  @override
  Widget build(BuildContext context) {
    _isDark = isDark(context);
    return Layout(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: double.maxFinite,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('trips')
                  .where("startLocation", isEqualTo: widget.origin)
                  .where("endLocation", isEqualTo: widget.destination)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: _isDark ? kTextColorLight : kBackgroundColorDark,
                    ),
                  );
                }

                var trips = snapshot.data!.docs
                    .map((document) => Trip.fromMap(
                        Map<String, dynamic>.from(document.data() as Map),
                        document.id))
                    .toList();
                return ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      return TripTile(
                        trip: trips[index],
                        from: trips[index].startLocation,
                        to: trips[index].endLocation,
                        depature: trips[index].startTime,
                        seats: trips[index].availableSeats,
                        price: trips[index].price,
                        duration: trips[index].duration,
                        isDark: _isDark,
                      );
                    });
              },
            ),
          ),
        ),
      )
    ]);
  }
}
