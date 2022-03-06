import 'package:brew_crew/models/coffee.dart';
import 'package:brew_crew/screens/home/coffee_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeList extends StatefulWidget {
  const CoffeeList({Key? key}) : super(key: key);

  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final coffees = Provider.of<List<Coffee>?>(context) ?? [];

    return ListView.builder(
      itemCount: coffees.length,
      itemBuilder: (context, index) {
        return CoffeeTile(coffee: coffees[index]);
      },
      );
  }
}
