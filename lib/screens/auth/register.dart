import 'package:coffeealert/constants/constant.dart';
import 'package:coffeealert/constants/loading.dart';
import 'package:coffeealert/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({@required this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Auth Service
  final AuthService _auth = AuthService();

  // form fields state
  String email = "";
  String password = "";
  String confirmPassword = "";
  String error = "";
  bool loading = false;

  //formKey
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text("Sign Up"),
              elevation: 0.0,
            ),
            body: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration,
                          validator: (value) {
                            return value.isEmpty
                                ? "Email can not be empty"
                                : null;
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
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          validator: (value) {
                            return value.length < 6
                                ? "Passsword must be greater than 6 character "
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
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: "Confirm Password",
                          ),
                          validator: (value) {
                            if (value.length < 6)
                              return "Passsword must be greater than 6 character ";
                            if (confirmPassword != password)
                              return "Passsword do not match ";

                            return null;
                          },
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              confirmPassword = value;
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
                              try {
                                setState(() {
                                  loading = true;
                                });
                                await _auth.registerWithEmail(email, password);
                              } catch (e) {
                                setState(() {
                                  error = e.message;
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            "Register",
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
                            "Have account ? Log in",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
