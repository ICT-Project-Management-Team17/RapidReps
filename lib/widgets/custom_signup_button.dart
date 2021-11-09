import 'package:flutter/material.dart';

class CustomSignUpButton extends StatelessWidget {
  final Color buttonColour;
  final double horizontalPadding;
  final String buttonText;
  final StatefulWidget pageRedirect;

  const CustomSignUpButton(
      {Key? key,
      required this.buttonColour,
      required this.horizontalPadding,
      required this.buttonText,
      required this.pageRedirect})
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageRedirect,
          ),
        );
      },
    );
  }
}
