import 'package:coffeealert/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Home"),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            child: Text("Log Out"),
          ),
        ),
      ),
    );
  }
}
