import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final String uid;
  FirebaseService({this.uid});

  final CollectionReference coffeeReference =
      FirebaseFirestore.instance.collection('coffee');

  Future updateData({String sugar, String name, int strength}) async {
    await coffeeReference.doc(uid).set({
      "name": name,
      "sugar": sugar,
      "strength": strength,
    });
  }

  // getting stream from firestore
  Stream<QuerySnapshot> get coffeeStream {
    return coffeeReference.snapshots();
  }
}
