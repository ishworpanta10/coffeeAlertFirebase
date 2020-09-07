import 'package:coffeealert/models/custom_user.dart';
import 'package:coffeealert/screens/auth/authenticate.dart';
import 'package:coffeealert/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrappper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return authscreen or home based on login info
    final user = Provider.of<CustomUser>(context);
    return user == null ? Authenticate() : Home();
  }
}
