import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeealert/models/coffee_model.dart';

class FirebaseService {
  final String uid;
  FirebaseService({this.uid});

  final CollectionReference coffeeReference =
      FirebaseFirestore.instance.collection('coffee');

  Future updateData(
      {String imgUrl, String sugar, String name, int strength}) async {
    await coffeeReference.doc(uid).set({
      "imgUrl": imgUrl,
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
          imgUrl: doc.data()['imgUrl']);
    }).toList();
  }

  // converting doc snapshot to user model
  UserModel _userModelFromDocSnap(DocumentSnapshot snapshot) {
    return UserModel(
        uid: uid,
        name: snapshot.data()['name'],
        sugar: snapshot.data()['sugar'],
        strength: snapshot.data()['strength'],
        imgUrl: snapshot.data()['imgUrl']);
  }

  // getting stream from firestore
  Stream<List<CoffeeModel>> get coffeeStream {
    return coffeeReference.snapshots().map(
        // (snap) => _listCoffeeFromSnap(snap).toList(),  same as below
        _listCoffeeFromSnap);
  }

  // getting user documents
  Stream<UserModel> get userStream {
    return coffeeReference.doc(uid).snapshots().map(_userModelFromDocSnap);
  }
}
