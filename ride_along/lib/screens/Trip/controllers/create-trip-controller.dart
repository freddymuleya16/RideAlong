import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/trip.dart';

class TripController {
  static CollectionReference tripsCollection =
      FirebaseFirestore.instance.collection('trips');

  static Future<bool> createTrip(Trip trip) async {
    try {
      final DocumentReference tripRef = await tripsCollection.add(trip.toMap());

      if (tripRef.id != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      print('Failed to create trip: ${e.toString()}');
      return false;
    } catch (e) {
      print('Failed to create trip: ${e.toString()}');
      return false;
    }
  }

  static Future<void> updateTrip(Trip trip) async {
    await tripsCollection.doc(trip.id).update(trip.toMap());
  }

  static Future<void> deleteTrip(String tripId) async {
    await tripsCollection.doc(tripId).delete();
  }

  static Future<List<Trip>> getTripsByUserId(String userId) async {
    QuerySnapshot querySnapshot = await tripsCollection
        //.where('driverId', isEqualTo: userId)
        //.where("passengerIds", arrayContains: userId)
        .get();
    //print({"jjjj", querySnapshot.docs.first.data()});

    var list = querySnapshot.docs
        .map((document) => Trip.fromMap(
            Map<String, dynamic>.from(document.data() as Map), document.id))
        .toList()
        .where((trip) =>
            trip.passengerIds.contains(userId) || trip.driverId == userId)
        .toList();
    list.sort((a, b) => b.startTime.compareTo(a.startTime));
    return list;
  }

  static Future<Trip?> getTrip(String id) async {
    DocumentSnapshot documentSnapshot = await tripsCollection.doc(id).get();
    if (documentSnapshot.exists) {
      return Trip.fromMap(
          Map<String, dynamic>.from(documentSnapshot.data() as Map),
          documentSnapshot.id);
    }
    return null;
  }
}
