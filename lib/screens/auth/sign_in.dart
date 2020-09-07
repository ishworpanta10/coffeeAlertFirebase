import 'package:coffeealert/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Sign In"),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: RaisedButton(
            onPressed: () async {
              dynamic user = await _auth.signInAnon();
              if (user != null) {
                print("Logged in User: ${user.uid} ");
              } else {
                print("User is Null");
              }
            },
            child: Text("Sign In Anon"),
          ),
        ),
      ),
    );
  }
}
