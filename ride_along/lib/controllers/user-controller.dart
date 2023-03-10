import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_along/models/user/user.dart';

class UserController {
  static CollectionReference tripsCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<AppUser?> getUser(String id) async {
    DocumentSnapshot documentSnapshot = await tripsCollection.doc(id).get();
    if (documentSnapshot.exists) {
      return AppUser.fromFirebase(
          Map<String, dynamic>.from(documentSnapshot.data() as Map),
          documentSnapshot.id);
    }
    return null;
  }
}
