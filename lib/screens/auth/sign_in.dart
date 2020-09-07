import 'package:coffeealert/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({@required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Auth service
  final AuthService _auth = AuthService();

  // form fields state
  String email = "";
  String password = "";
  String error = "";

  // formkey
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Sign In"),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (value) {
                      return value.isEmpty ? "Email can not be empty" : null;
                    },
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (value) {
                      return value.length < 6
                          ? "Passsword can not be less than 6 character"
                          : null;
                    },
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(fontSize: 14.0, color: Colors.red),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic user =
                            await _auth.signInWithEmail(email, password);
                        if (user == null) {
                          setState(() {
                            error = "Invalid Credential";
                          });
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text(
                      "Have no account ? Register",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GoogleSignInButton(
                    darkMode: true,
                    onPressed: () async {
                      dynamic user = await _auth.signInWithGoogle();
                      if (user == null) {
                        setState(() {
                          error = "Error Goolgle Sign In";
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
