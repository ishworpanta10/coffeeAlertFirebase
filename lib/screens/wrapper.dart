import 'package:coffeealert/screens/auth/authenticate.dart';
import 'package:coffeealert/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrappper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return authscreen or home based on login info
    return Authenticate();
  }
}
