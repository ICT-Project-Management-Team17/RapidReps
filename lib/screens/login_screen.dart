import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
<<<<<<< HEAD
import '../models/export.dart';
=======
import 'package:rapid_reps/models/cdo_model.dart';
import 'package:rapid_reps/models/firm_rep_model.dart';
import 'package:rapid_reps/models/solicitor.dart';
import 'package:rapid_reps/models/user_model.dart';
>>>>>>> 0881e475b26e5fed32621c9d01b9e5751464a549
import '../widgets/export.dart';
import 'export.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  String? errorText;

  User? user;

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
            // mainAxisAlignment: MainAxisAlignment.center,
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
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 36.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
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
                          height: 25,
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
                          height: 25,
                        ),
                        CustomButton(
                          buttonColour: const Color(0xFF009FE3),
                          horizontalPadding: 70,
                          buttonText: 'Login',
                          onPressed: () {
                            loginAccount(
                                emailController.text, passwordController.text);
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          buttonColour: const Color(0xFF951B81),
                          horizontalPadding: 60,
                          buttonText: 'Sign Up',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const InitialSignUpScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const TextButton(
                          onPressed: null,
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
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

  // Login function
  void loginAccount(String email, String password) async {
    //userModel currentUser;
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((userID) => {
                  //currentUser = userModel(),
                  user = FirebaseAuth.instance.currentUser,
                  // user = _auth.currentUser,
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user!.uid)
                      .get()
                      .then((curUser) {
                    String userType = curUser.data()!['userType'];
                    if (userType == 'CDO') {
<<<<<<< HEAD
                      currentUser = CDOModel.fromMap(curUser.data());
=======
                      CDOModel currentUser = CDOModel.fromMap(curUser.data());

>>>>>>> 0881e475b26e5fed32621c9d01b9e5751464a549
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              CDODashboard(currentUser: currentUser)));
                    } else if (userType == 'Solicitor') {
<<<<<<< HEAD
                      currentUser = SolicitorModel.fromMap(curUser.data());
=======
                      SolicitorModel currentUser =
                          SolicitorModel.fromMap(curUser.data());
>>>>>>> 0881e475b26e5fed32621c9d01b9e5751464a549
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              SolicitorDashboard(currentUser: currentUser)));
                    } else if (userType == 'Firm Rep') {
<<<<<<< HEAD
                      currentUser = FirmRep.fromMap(curUser.data());
=======
                      FirmRep currentUser = FirmRep.fromMap(curUser.data());
>>>>>>> 0881e475b26e5fed32621c9d01b9e5751464a549
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              FirmRepDashboard(currentUser: currentUser)));
                    }
                  }),
                });
      } on FirebaseAuthException catch (error) {
        errorText = error.code;
        if (errorText == 'user-not-found' || errorText == 'wrong-password') {
          errorText = 'Incorrect Email & Password';
        }
        // Flutter toast used to show the 'incorrect password' error
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
}
