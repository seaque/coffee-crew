import 'package:brew_crew/models/myuser.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentChoice;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update Coffee Settings',
                    style: TextStyle(fontSize: 18.0, color: Colors.brown),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration,
                    validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField(
                          value: _currentSugars == ' ' ? sugars[0] : userData!.sugars,
                          decoration: textInputDecoration,
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text('$sugar sugars'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => _currentSugars = val.toString()),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(child: TextFormField(
                    initialValue: userData?.choice,
                    decoration: textInputDecoration,
                    validator: (val) => val!.isEmpty ? 'Please enter a coffee choice' : null,
                    onChanged: (val) => setState(() => _currentChoice = val),
                  ),
                  )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Slider(
                      value: (_currentStrength ?? userData!.strength).toDouble(),
                      min: 0.0,
                      max: 900.0,
                      onChanged: (val) => setState(() => _currentStrength = val.round()),
                      inactiveColor: Colors.brown[100],
                      activeColor: Colors.brown,
                      divisions: 20),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                      style: raisedButtonStyleBrown,
                      child: const Text('Update', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(_currentName ?? userData!.name, _currentChoice ?? userData!.choice, _currentSugars ?? userData!.sugars, _currentStrength ?? userData!.strength);
                        }
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
