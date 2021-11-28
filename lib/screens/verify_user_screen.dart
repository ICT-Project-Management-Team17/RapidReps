import 'package:flutter/material.dart';
import 'package:rapid_reps/screens/export.dart';
import 'package:rapid_reps/widgets/export.dart';

class VerifyUser extends StatefulWidget {
  final String? email;
  const VerifyUser({Key? key, this.email}) : super(key: key);

  @override
  _VerifyUserState createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('An Email has been sent to ${widget.email} please verify'),
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
