import 'package:coffeealert/models/coffee_model.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  final CoffeeModel coffee;

  const CoffeeTile({this.coffee});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown[100],
            backgroundImage: NetworkImage(coffee.imgUrl ?? ""),
          ),
          trailing: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage("assets/images/coffee_icon.png"),
            backgroundColor: Colors.brown[coffee.strength],
          ),
          title: Text(
            coffee.name,
            style: TextStyle(),
          ),
          subtitle: Text("Takes ${coffee.sugar} sugar(s)"),
        ),
      ),
    );
  }
}
