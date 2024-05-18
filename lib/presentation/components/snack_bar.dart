import 'package:flutter/material.dart';

class CustomSnackBar {
  final String message;

  CustomSnackBar({required this.message});

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust duration as needed
      ),
    );
  }
}
