import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rapid_reps/models/export.dart';
import 'package:rapid_reps/screens/export.dart';
import 'package:rapid_reps/services/custom_toast.dart';
import 'package:rapid_reps/widgets/custom_button.dart';

class ForgotYourPassword extends StatefulWidget {
  final Color userColour;
  const ForgotYourPassword({Key? key, required this.userColour})
      : super(key: key);

  @override
  _ForgotYourPasswordState createState() => _ForgotYourPasswordState();
}

class _ForgotYourPasswordState extends State<ForgotYourPassword> {
  final TextEditingController currentEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/London.png"), fit: BoxFit.cover),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 500,
                width: 325,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text("Reset Password",
                            style: TextStyle(fontSize: 36.0)),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: currentEmailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email!.isEmpty) {
                              return "Please enter your email";
                            }
                            // Email validation
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            currentEmailController.text = value!;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          buttonColour: const Color(0xFFF49413),
                          horizontalPadding: 70,
                          buttonText: 'Reset',
                          onPressed: () async {
                            sendPasswordResetEmail();
                            Navigator.pushNamed(
                                context, "Your reset mail has been sent.");
                          },
                        ),
                        CustomButton(
                          buttonColour: const Color(0xFFF49413),
                          horizontalPadding: 70,
                          buttonText: 'Back',
                          onPressed: () {
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        await _auth.sendPasswordResetEmail(email: currentEmailController.text);
      } on FirebaseAuthException catch (error) {
        errorText = error.code;
        if (errorText == 'Sorry we could not find your accout') {}
        customToast(msg: errorText!, backgroundColor: Colors.red);
      }
    }
  }
}
