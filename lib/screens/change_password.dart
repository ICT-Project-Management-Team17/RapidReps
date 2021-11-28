import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rapid_reps/screens/export.dart';
import '../widgets/export.dart';
import '../utilities/export.dart';

class ChangePassword extends StatefulWidget {
  final Color userColour;
  const ChangePassword({Key? key, required this.userColour}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
        backgroundColor: kCDOColour,
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
                        controller: currentPasswordController,
                        validator: (currentPassword) {
                          // RegExp regex = RegExp(r'^.{6,}$');
                          if (currentPassword!.isEmpty) {
                            return 'You need to enter in your current password';
                          }
                          if (!RegExp(r'^.{6,}$').hasMatch(currentPassword)) {
                            return "Enter a valid password (Min 6 chars)";
                          }
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSaved: (currentPassword) {
                          currentPasswordController.text = currentPassword!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Current Password',
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
                            return 'Enter in a new password';
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
                            hintText: 'New Password',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        validator: (password) {
                          // RegExp regex = RegExp(r'^.{6,}$');
                          if (passwordController.text != password) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSaved: (password) {
                          confirmPasswordController.text = password!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Confirm New Password',
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
                buttonColour: kCDOColour,
                horizontalPadding: 25,
                buttonText: 'Submit',
                onPressed: () {
                  updatePassword(
                      currentPasswordController.text, passwordController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePassword(String currentPassword, String newPassword) async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(
            email: user!.email as String, password: currentPassword);
        await user
            .reauthenticateWithCredential(cred)
            .then((value) => user.updatePassword(newPassword));
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
        }
        Fluttertoast.showToast(
          msg: errorText!,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }
}
