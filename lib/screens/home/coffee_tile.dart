import 'package:flutter/material.dart';
import 'package:brew_crew/models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  const CoffeeTile({Key? key, required this.coffee}) : super(key: key);

  final Coffee coffee;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.brown[coffee.strength],
            backgroundImage: const AssetImage('assets/images/coffee_icon.png'),
          ),
          title: Text(coffee.name),
          subtitle: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                const WidgetSpan(child: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(Icons.coffee, size: 16.0),
                )),
                TextSpan(text: coffee.choice),
                const WidgetSpan(child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 3, 0),
                  child: Image(image: AssetImage('assets/images/sugars.jpg'), width: 16.0, height: 16.0),
                )),
                TextSpan(text: coffee.sugars),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
