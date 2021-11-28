import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/export.dart';
import '../utilities/export.dart';

class CDOEditProfile extends StatefulWidget {
  final CDOModel currentUser;
  const CDOEditProfile({Key? key, required this.currentUser}) : super(key: key);

  @override
  _CDOEditProfileState createState() => _CDOEditProfileState();
}

class _CDOEditProfileState extends State<CDOEditProfile> {
  late String _policeStation = 'West Wickham Police Office   BR4 0LP';
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController telephoneNumberController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: kCDOColour,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
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
              TextFormField(
                controller: emailController,
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
                  emailController.text = value!;
                },
                decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirmEmailController,
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (emailController.text != email) {
                    return "Email does not match";
                  }

                  return null;
                },
                onSaved: (value) {
                  confirmEmailController.text = value!;
                },
                decoration: const InputDecoration(
                    hintText: 'Confirm Email',
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
                    hintText: 'Confirm Password',
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
    );
  }
}
