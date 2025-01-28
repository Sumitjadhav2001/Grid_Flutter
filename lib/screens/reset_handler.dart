import 'package:flutter/material.dart';

class ResetHandler {
  static void resetApp(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
          (Route<dynamic> route) => false,
    );
  }
}
