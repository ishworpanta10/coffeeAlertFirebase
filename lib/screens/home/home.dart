import 'package:coffeealert/models/coffee_model.dart';
import 'package:coffeealert/screens/home/coffeeList.dart';
import 'package:coffeealert/services/auth.dart';
import 'package:coffeealert/services/firebaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CoffeeModel>>.value(
      value: FirebaseService().coffeeStream,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("Home"),
          elevation: 0.0,
          actions: [
            FlatButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: CoffeeList(),
      ),
    );
  }
}
