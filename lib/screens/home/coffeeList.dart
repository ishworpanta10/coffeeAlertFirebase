import 'package:coffeealert/models/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final coffee = Provider.of<List<CoffeeModel>>(context);

    coffee.forEach((item) {
      print(item.name);
      print(item.sugar);
      print(item.strength);
    });

    return Container();
  }
}
