import 'package:flutter/material.dart';

void showSnackbarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xff80AF81)
    ),
  );
}
