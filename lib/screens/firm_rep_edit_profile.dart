import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:rapid_reps/models/export.dart';
import 'package:rapid_reps/services/export.dart';
import 'package:rapid_reps/utilities/constants.dart';
import 'package:rapid_reps/widgets/export.dart';

// ignore: must_be_immutable
class FirmRepEditProfile extends StatefulWidget {
  late FirmRep currentUser;
  FirmRepEditProfile({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  _FirmRepEditProfileState createState() => _FirmRepEditProfileState();
}

class _FirmRepEditProfileState extends State<FirmRepEditProfile> {
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController telephoneNumberController =
      TextEditingController();
  final TextEditingController firmNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorText;

  updateProfileInfo() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.currentUser.uid)
        .get()
        .then((value) {
      widget.currentUser = FirmRep.fromMap(value.data());
    });
    return widget.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: kFirmRepColour,
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
                        controller: mobileNumberController,
                        validator: (mobileNum) {
                          if (mobileNum!.isEmpty) {
                            return 'A mobile number is required';
                          }
                          if (!RegExp(r'^.{10,}$').hasMatch(mobileNum)) {
                            return "Mobile Number must be at least 10-digits";
                          }

                          return null;
                        },
                        onSaved: (mobileNum) {
                          mobileNumberController.text = mobileNum!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: telephoneNumberController,
                        validator: (teleNum) {
                          if (teleNum!.isEmpty) return null;
                          if (!RegExp(r'^.{10,}$').hasMatch(teleNum)) {
                            return "Telephone Number must be at least 10-digits";
                          }
                        },
                        onSaved: (teleNum) {
                          telephoneNumberController.text = teleNum!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Telephone Number',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: firmNameController,
                        validator: (firmName) {
                          if (firmName!.isEmpty) {
                            return 'Please enter your Firm name';
                          }
                        },
                        onSaved: (firmName) {
                          firmNameController.text = firmName!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter name of firm',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                buttonColour: kSolicitorColour,
                horizontalPadding: 25,
                buttonText: 'Update Profile',
                onPressed: () {
                  updateProfile(mobileNumberController.text,
                      telephoneNumberController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateProfile(String mobileNumber, String telephoneNumber) async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = _auth.currentUser;
        var collection = FirebaseFirestore.instance.collection('users');

        collection.doc(user!.uid).update({
          'mobileNumber': mobileNumber,
          'telephoneNumber': telephoneNumber,
          'firm': firmNameController.text,
        });

        customToast(
          msg: 'Updates Applied',
          backgroundColor: Colors.red,
        );
        Navigator.pop(context, updateProfileInfo());
      } on FirebaseAuthException catch (error) {
        errorText = error.code;
        if (errorText == 'too-many-requests') {
          errorText =
              'Too many requests have been sent, please try again later';
        }
        customToast(
          msg: errorText!,
          backgroundColor: Colors.red,
        );
      }
    }
  }
}
