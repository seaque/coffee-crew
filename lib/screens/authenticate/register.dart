import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  bool passwordObscure = true;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              backgroundColor: Colors.brown[500],
              elevation: 0.0,
              title: const Text('Sign Up to Coffee Crew'),
              actions: <Widget>[
                ElevatedButton.icon(
                    style: flatButtonStyleBrown,
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: const Icon(Icons.person, color: Colors.white),
                    label: const Text('Sign In', style: TextStyle(color: Colors.white)))
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Email', focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan[500]!, width: 3.0))),
                          validator: (val) => val!.isEmpty ? 'Enter an e-mail' : null,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) {
                            setState(() 
                            {
                              email = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                  color: Colors.cyan,
                                  onPressed: () {
                                    setState(() {
                                      passwordObscure = !passwordObscure;
                                    });
                                  },
                                  icon: Icon(passwordObscure ? Icons.visibility_off : Icons.visibility)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan[500]!, width: 3.0))),
                          validator: (val) => val!.length < 6 ? 'Enter a password with at least six characters' : null,
                          obscureText: passwordObscure,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: raisedButtonStyleCyan,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() => error = 'Please add a valid e-mail.');
                                loading = false;
                              }
                            }
                          },
                          child: const Text('Submit', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          error,
                          style: const TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ],
                    ))),
          );
  }
}
