import 'package:coffeealert/constants/constant.dart';
import 'package:coffeealert/constants/loading.dart';
import 'package:coffeealert/models/coffee_model.dart';
import 'package:coffeealert/models/custom_user.dart';
import 'package:coffeealert/services/firebaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    return StreamBuilder(
      stream: FirebaseService(uid: user.uid).userStream,
      builder: (context, snapshot) {
        UserModel userData = snapshot.data;
        if (!snapshot.hasData) {
          return Loading();
        } else {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Update your Coffee Setting",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: "Name"),
                  validator: (value) =>
                      value.isEmpty ? "Plaese enter your name" : null,
                  onChanged: (value) {
                    setState(() {
                      _currentName = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                // dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugar,
                  items: sugars
                      .map((sugar) => DropdownMenuItem(
                            value: sugar,
                            child: Text("$sugar sugars"),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentSugars = value;
                    });
                  },
                ),
                // slider for sugar
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  activeColor: Colors.brown[_currentStrength],
                  inactiveColor: Colors.brown[_currentStrength],
                  onChanged: (value) {
                    setState(() => _currentStrength = value.round());
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  onPressed: () async {
                    print(_currentName);
                    print(_currentSugars);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
