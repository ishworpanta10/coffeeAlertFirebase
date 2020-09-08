import 'package:coffeealert/models/coffee_model.dart';
import 'package:coffeealert/widgets/coffeeTile.dart';
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

    return ListView.builder(
      itemCount: coffee.length,
      itemBuilder: (BuildContext context, int index) {
        return CoffeeTile(
          coffee: coffee[index],
        );
      },
    );
  }
}
