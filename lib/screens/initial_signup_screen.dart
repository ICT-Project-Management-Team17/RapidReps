import 'package:flutter/material.dart';

class InitialSignUpScreen extends StatefulWidget {
  const InitialSignUpScreen({Key? key}) : super(key: key);

  @override
  _InitialSignUpScreenState createState() => _InitialSignUpScreenState();
}

class _InitialSignUpScreenState extends State<InitialSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/london.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Text(
                'Center Widget',
                textScaleFactor: 3,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
