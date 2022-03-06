import 'package:brew_crew/models/coffee.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/coffee_list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: const SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Coffee>?>.value(
      value: DatabaseService(uid: '').coffees,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Coffee Crew'),
          backgroundColor: Colors.brown[500],
          elevation: 0.0,
          actions: <Widget>[
            ElevatedButton.icon(
              icon: const Icon(Icons.person, color: Colors.white),
              label: const Text('Logout', style: TextStyle(color: Colors.white)),
              style: flatButtonStyleBrown,
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            ElevatedButton.icon(
                style: flatButtonStyleBrown,
                onPressed: () {
                  _showSettingsPanel();
                },
                icon: const Icon(Icons.settings, color: Colors.white),
                label: const Text('Settings', style: TextStyle(color: Colors.white))),
          ],
        ),
        body: Container(
          child: const CoffeeList(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
