import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reps/screens/export.dart';
import 'package:rapid_reps/services/export.dart';
import 'package:rapid_reps/widgets/export.dart';

class ForgotYourPassword extends StatefulWidget {
  const ForgotYourPassword({Key? key}) : super(key: key);

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
            image: AssetImage("assets/images/london.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                          buttonColour: const Color(0xFF951B81),
                          horizontalPadding: 70,
                          buttonText: 'Reset',
                          onPressed: () async {
                            sendPasswordResetEmail();
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          buttonColour: const Color(0xFFF49413),
                          horizontalPadding: 70,
                          buttonText: 'Back',
                          onPressed: () {
                            Navigator.pop(context);
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
        await _auth.sendPasswordResetEmail(email: currentEmailController.text);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const RedirectToLoginScreen(
              textToDisplay: 'Password Email has been sent',
            ),
          ),
        );
      } on FirebaseAuthException catch (error) {
        errorText = error.code;
        if (errorText == 'user-not-found') {
          errorText = 'Incorrect Email';
        } else if (errorText == 'too-many-requests') {
          errorText =
              'Too many requests have been sent, please try again later';
        }
        // Flutter toast used to show the 'incorrect password' error
        customToast(
          msg: errorText!,
          backgroundColor: Colors.red,
        );
      }
    }
  }
}
