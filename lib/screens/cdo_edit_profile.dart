import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reps/services/export.dart';
import 'package:rapid_reps/widgets/export.dart';
import '../models/export.dart';
import '../utilities/export.dart';

// ignore: must_be_immutable
class CDOEditProfile extends StatefulWidget {
  late CDOModel currentUser;
  CDOEditProfile({Key? key, required this.currentUser}) : super(key: key);

  @override
  _CDOEditProfileState createState() => _CDOEditProfileState();
}

class _CDOEditProfileState extends State<CDOEditProfile> {
  late String _policeStation = 'West Wickham Police Office   BR4 0LP';
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController telephoneNumberController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  String? errorText;

  updateProfileInfo() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.currentUser.uid)
        .get()
        .then((value) {
      widget.currentUser = CDOModel.fromMap(value.data());
    });
    return widget.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
                        height: 20,
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
                        height: 20,
                      ),
                      DropdownButton<String>(
                        hint: const Text(
                          "Select a Police Station",
                        ),
                        icon: const Icon(
                          Icons.arrow_downward,
                        ),
                        isExpanded: true,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        items: <String>[
                          'West Wickham Police Office   BR4 0LP',
                          'Croydon Police Station   CR0 6SR',
                          'Berlin Underwood House   CR20 2XR'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _policeStation = value as String;
                          });
                        },
                        value: _policeStation,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                buttonColour: kCDOColour,
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
          'policeStation': _policeStation,
          'telephoneNumber': telephoneNumber
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
