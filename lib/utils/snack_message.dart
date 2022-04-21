import 'package:flutter/material.dart';


void showMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message!,
        style: TextStyle(color: Colors.white),
      ),
  backgroundColor: Colors.indigo,
  ));
}