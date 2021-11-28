import 'package:flutter/material.dart';

TextButton customIconButton(
  BuildContext context, {
  required String label,
  required Color backgroundColour,
  required double horizontalPadding,
  required IconData icon,
  required var onPressed,
}) {
  return TextButton.icon(
    onPressed: onPressed,
    icon: Icon(icon),
    label: Text(label),
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: backgroundColour,
      textStyle: const TextStyle(fontSize: 20),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
  );
}
