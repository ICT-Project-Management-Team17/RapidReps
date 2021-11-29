import 'package:flutter/material.dart';
import 'package:rapid_reps/screens/export.dart';
import 'package:rapid_reps/widgets/export.dart';

class RedirectToLoginScreen extends StatefulWidget {
  final String textToDisplay;
  const RedirectToLoginScreen({
    Key? key,
    required this.textToDisplay,
  }) : super(key: key);

  @override
  _RedirectToLoginScreenState createState() => _RedirectToLoginScreenState();
}

class _RedirectToLoginScreenState extends State<RedirectToLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Center(
              child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.textToDisplay),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                buttonColour: Colors.purple,
                horizontalPadding: 25,
                buttonText: 'Continue',
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                }),
          ],
        ),
      ))),
    );
  }
}
