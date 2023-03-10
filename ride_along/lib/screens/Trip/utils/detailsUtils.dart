import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/models/trip.dart';
import 'package:ride_along/models/user/user.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class DetailsUtils {
  static var btn = RoundedLoadingButtonController();

  static Future<String?> _requestTrip(String userId, String tripId) async {
    try {
      // Get the trip document from the database.
      final tripDoc =
          FirebaseFirestore.instance.collection('trips').doc(tripId);
      final tripSnapshot = await tripDoc.get();

      if (!tripSnapshot.exists) {
        return 'This trip no longer exists.';
      }

      // Check if the trip is still available.
      final trip = Trip.fromMap(
          Map<String, dynamic>.from(tripSnapshot.data() as Map), tripDoc.id);

      if (trip.status == TripStatus.cancelled) {
        return 'This trip has already been cancelled.';
      }

      if (trip.status == TripStatus.completed) {
        return 'This trip has already been completed.';
      }

      if (trip.status == TripStatus.inProgress) {
        return 'This trip is already in progress.';
      }

      if (trip.passengerIds.contains(userId)) {
        return 'This trip has already been accepted by a driver.';
      }

      if (trip.requestedPassengerIds.contains(userId)) {
        return 'This trip is waiting for driver.';
      }

      if (trip.rejectedPassengerIds.contains(userId)) {
        return 'This trip has already been rejected by a driver.';
      }

      if (trip.availableSeats == 0) {
        return 'This trip has no seats available.';
      }

      // Add the current user's ID to the trip's passengerIds field and increment the passengerCount.
      final updatedPassengerIds = [...trip.passengerIds, userId];
      //final updatedPassengerCount = trip.availableSeats - 1;

      // Update the trip document in the database with the new passenger information.
      await tripDoc.update({
        'requestedPassengerIds': updatedPassengerIds,
        //'availableSeats': updatedPassengerCount,
      });

      return null; // Indicate success with a null value.
    } catch (e) {
      return 'An error occurred while requesting the trip: $e';
    }
  }

  static void onPressed(BuildContext context, uid, tId) async {
    bool _isDark = isDark(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: _isDark ? Colors.white : kSecondaryColor,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );

    // Perform the asynchronous task here
    try {
      var res = await _requestTrip(uid, tId);
      if (res != null) {
        throw (Exception(res));
      }
      Timer(const Duration(seconds: 2), () {
        btn.success();
        Timer(const Duration(milliseconds: 1500), () {
          Navigator.pop(context);
          btn.reset();
        });
      });
      // Do something after task is completed
    } catch (e) {
      Timer(const Duration(seconds: 2), () {
        btn.error();
        Timer(const Duration(seconds: 2), () {
          btn.reset();
        });
      });
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          content: Text(e.toString().replaceAll(RegExp(r'Exception: '), '')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  static Future<void> addRequestedPassenger(
      String tripId, String userId) async {
    try {
      final DocumentReference tripRef =
          FirebaseFirestore.instance.collection('trips').doc(tripId);

      await FirebaseFirestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot tripSnapshot = await tx.get(tripRef);

        if (!tripSnapshot.exists) {
          throw Exception('Trip does not exist');
        }

        Trip trip = Trip.fromMap(
            Map<String, dynamic>.from(tripSnapshot.data() as Map),
            tripSnapshot.id);

        if (trip.driverId == userId) {
          throw Exception('Driver cannot request to join their own trip');
        }

        if (trip.passengerIds.contains(userId)) {
          throw Exception(
              'Passenger has already requested to join or is already a member of this trip');
        }

        trip.passengerIds.add(userId);
        trip.requestedPassengerIds.remove(userId);
        final updatedPassengerCount = trip.availableSeats - 1;

        await tx.update(tripRef, {
          'requestedPassengerIds': trip.requestedPassengerIds,
          'passengerIds': trip.passengerIds,
          'availableSeats': updatedPassengerCount
        });
      });
    } catch (e) {
      print('Error adding requested passenger: $e');
      rethrow;
    }
  }

  static Future<void> rejectRequestedPassenger(
      String tripId, String userId) async {
    try {
      final DocumentReference tripRef =
          FirebaseFirestore.instance.collection('trips').doc(tripId);

      await FirebaseFirestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot tripSnapshot = await tx.get(tripRef);

        if (!tripSnapshot.exists) {
          throw Exception('Trip does not exist');
        }

        Trip trip = Trip.fromMap(
            Map<String, dynamic>.from(tripSnapshot.data() as Map),
            tripSnapshot.id);

        if (trip.driverId == userId) {
          throw Exception('Driver cannot request to join their own trip');
        }

        if (trip.rejectedPassengerIds.contains(userId)) {
          throw Exception(
              'Passenger has already requested to join or is already a member of this trip');
        }

        trip.rejectedPassengerIds.add(userId);
        trip.requestedPassengerIds.remove(userId);

        await tx.update(tripRef, {
          'requestedPassengerIds': trip.requestedPassengerIds,
          'rejectedPassengerIds': trip.rejectedPassengerIds,
        });
      });
    } catch (e) {
      print('Error adding requested passenger: $e');
      rethrow;
    }
  }
}
