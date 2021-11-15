import 'package:flutter/material.dart';
import 'export.dart';
import '../widgets/export.dart';

class FirmRepSignUpScreen extends StatefulWidget {
  final Color userColour;
  const FirmRepSignUpScreen({
    Key? key,
    required this.userColour,
  }) : super(key: key);

  @override
  _FirmRepSignUpScreenState createState() => _FirmRepSignUpScreenState();
}

class _FirmRepSignUpScreenState extends State<FirmRepSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: widget.userColour),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: widget.userColour,
                  width: 5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Firstname',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Lastname',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Telephone Number',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Confirm Email',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter name of firm',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonColour: widget.userColour,
              horizontalPadding: 25,
              buttonText: 'Submit',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConstructionPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
