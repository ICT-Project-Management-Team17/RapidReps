import 'package:flutter/material.dart';

class InitialSignUpScreen extends StatefulWidget {
  const InitialSignUpScreen({Key? key}) : super(key: key);

  @override
  _InitialSignUpScreenState createState() => _InitialSignUpScreenState();
}

class _InitialSignUpScreenState extends State<InitialSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/london.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
