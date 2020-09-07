import 'package:coffeealert/constants/constant.dart';
import 'package:coffeealert/services/auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final AuthService _auth = AuthService();
  String email = "";
  String error = "";

  Widget _showAlert({@required String error}) {
    if (error.isNotEmpty) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.error_outline),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                error,
                maxLines: 3,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  error = null;
                  Navigator.pop(context);
                });
              },
            )
          ],
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Forget Password"),
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            _showAlert(error: error),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              decoration: textInputDecoration,
              onSubmitted: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            // Text(
            //   error,
            //   style: TextStyle(color: Colors.red, fontSize: 14.0),
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            RaisedButton(
              onPressed: () async {
                try {
                  await _auth.resetPasswordWithEmail(email);
                  setState(() {
                    error = "Password reset link send to $email";
                  });
                } catch (e) {
                  print(e);
                  setState(() {
                    error = "Failed to send reset password Invalid request";
                  });
                }
              },
              child: Text("Reset Password"),
            )
          ],
        ),
      ),
    );
  }
}
