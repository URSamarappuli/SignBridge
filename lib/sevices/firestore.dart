import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // get collection of users
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //create : add user to database
  Future<void> createUser(
      String uid, String email, String fullName, String phoneNumber) async {
    try {
      await users.doc(uid).set({
        'email': email,
        'full name': fullName,
        'phone number': phoneNumber,
      });
    } catch (e) {
      //print("Error creating user: $e");
    }
  }

  //read : get users from database
  Stream<QuerySnapshot> getUserDetails() {
    final User user = FirebaseAuth.instance.currentUser!;
    return _firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .snapshots();
  }

  //update: update usera given a document id

  //delete: delete usera given a document id
}
