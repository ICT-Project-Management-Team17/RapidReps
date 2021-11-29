import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rapid_reps/screens/export.dart';
import 'package:rapid_reps/services/export.dart';
import '../widgets/export.dart';

class ChangeEmail extends StatefulWidget {
  final Color userColor;
  const ChangeEmail({Key? key, required this.userColor}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final TextEditingController currentEmailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Email'),
        centerTitle: true,
        backgroundColor: widget.userColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: currentEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return "Please enter your current email";
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
                            hintText: 'Current Email',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: newEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return "Please enter your new email";
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
                          newEmailController.text = value!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'New Email',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: confirmEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (newEmailController.text != email) {
                            return "Email does not match";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          confirmEmailController.text = value!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Confirm New Email',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (password) {
                          // RegExp regex = RegExp(r'^.{6,}$');
                          if (password!.isEmpty) {
                            return 'A Password is required to login';
                          }
                          if (!RegExp(r'^.{6,}$').hasMatch(password)) {
                            return "Enter a valid password (Min 6 chars)";
                          }
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSaved: (password) {
                          passwordController.text = password!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                buttonColour: widget.userColor,
                horizontalPadding: 25,
                buttonText: 'Submit',
                onPressed: () {
                  updateEmail(currentEmailController.text,
                      newEmailController.text, passwordController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateEmail(
      String currentEmail, String newEmail, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(
            email: currentEmail, password: password);
        await user!
            .reauthenticateWithCredential(cred)
            .then((value) => user.updateEmail(newEmail));
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const RedirectToLoginScreen(
                  textToDisplay:
                      'Login Credentials were changed, please login with new credentials',
                )));
      } on FirebaseAuthException catch (error) {
        errorText = error.code;
        if (errorText == 'too-many-requests') {
          errorText =
              'Too many requests have been sent, please try again later';
        } else if (errorText == 'wrong-password') {
          errorText = 'Current password was incorrect, please try again';
        } else if (errorText == 'wrong-email') {
          errorText = 'Wrong email entered, please try again';
        }
        customToast(
          msg: errorText!,
          backgroundColor: Colors.red,
        );
        
      }
    }
  }
}
