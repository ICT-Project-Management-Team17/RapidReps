import 'package:flutter/material.dart';
import 'package:rapid_reps/screens/export.dart';
import 'package:rapid_reps/widgets/export.dart';

class CredentialChange extends StatefulWidget {
  const CredentialChange({Key? key}) : super(key: key);

  @override
  _CredentialChangeState createState() => _CredentialChangeState();
}

class _CredentialChangeState extends State<CredentialChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
              'Login Credentials were changed, please login with new credentials'),
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
    )));
  }
}
