import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeealert/models/coffee_model.dart';

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

  List<CoffeeModel> _listCoffeeFromSnap(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CoffeeModel(
        name: doc.data()['name'],
        sugar: doc.data()['sugar'],
        strength: doc.data()['strength'],
      );
    }).toList();
  }

  // getting stream from firestore
  Stream<List<CoffeeModel>> get coffeeStream {
    return coffeeReference.snapshots().map(
        // (snap) => _listCoffeeFromSnap(snap).toList(),  same as below
        _listCoffeeFromSnap);
  }
}
