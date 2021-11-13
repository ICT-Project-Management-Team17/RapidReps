import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColour;
  final double horizontalPadding;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton(
      {Key? key,
      required this.buttonColour,
      required this.horizontalPadding,
      required this.buttonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColour,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 10,
        ),
        textStyle: const TextStyle(fontSize: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
      ),
      onPressed: onPressed,
    );
  }
}
