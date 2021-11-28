import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/export.dart';
import 'export.dart';
import '../widgets/export.dart';

class CDOSignUpScreen extends StatefulWidget {
  final Color userColour;
  const CDOSignUpScreen({
    Key? key,
    required this.userColour,
  }) : super(key: key);

  @override
  _CDOSignUpScreenState createState() => _CDOSignUpScreenState();
}

class _CDOSignUpScreenState extends State<CDOSignUpScreen> {
  late String _policeStation = 'West Wickham Police Office   BR4 0LP';

  final userType = 'CDO';

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController telephoneNumberController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  String? errorText;

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        validator: (firstName) {
                          if (firstName!.isEmpty) {
                            return 'First Name is required for signup';
                          }

                          return null;
                        },
                        onSaved: (firstName) {
                          firstNameController.text = firstName!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Firstname',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: lastNameController,
                        validator: (lastName) {
                          if (lastName!.isEmpty) {
                            return 'Last Name is required for signup';
                          }

                          return null;
                        },
                        onSaved: (lastName) {
                          lastNameController.text = lastName!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Lastname',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonColour: widget.userColour,
              horizontalPadding: 25,
              buttonText: 'Submit',
              onPressed: () {
                signup(emailController.text, passwordController.text);
              },
            ),
          ],
        ),
      ),
    );
  }

  void signup(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {createUser()});
      } on FirebaseAuthException catch (error) {
        errorText = error.code;
        if (errorText == 'email-already-in-use') {
          errorText = 'User with this Email already exists';
        }
        Fluttertoast.showToast(
            msg: errorText!,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  createUser() async {
    CDOModel userModel = CDOModel();
    User? user = _auth.currentUser;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Entering new CDO user fields
    userModel.uid = user!.uid;
    userModel.firstName = firstNameController.text;
    userModel.lastName = lastNameController.text;
    userModel.mobileNumber = mobileNumberController.text;
    userModel.telephoneNumber = telephoneNumberController.text;
    userModel.email = user.email;
    userModel.policeStation = _policeStation;
    userModel.userType = userType;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    user.sendEmailVerification();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => VerifyUser(email: user.email)));
  }
}
