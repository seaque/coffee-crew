import 'package:flutter/material.dart';

final ButtonStyle raisedButtonStyleBrown = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.brown[500],
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
);

final ButtonStyle raisedButtonStyleCyan = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.cyan[600],
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
);

final ButtonStyle flatButtonStyleCyan = TextButton.styleFrom(
  primary: Colors.black87,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  backgroundColor: Colors.cyan[500]
);

final ButtonStyle flatButtonStyleBrown = TextButton.styleFrom(
  primary: Colors.black87,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  backgroundColor: Colors.brown[500]
);

const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 3.0)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.brown, width: 3.0)),
  );
