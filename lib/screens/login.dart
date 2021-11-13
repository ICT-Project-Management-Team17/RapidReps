import 'package:flutter/material.dart';
import '../widgets/export.dart';
import 'export.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      height: 450,
                      width: 325,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: const [
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 36.0,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomSignUpButton(
                              buttonColour: Color(0xFF009FE3),
                              horizontalPadding: 70,
                              buttonText: 'Login',
                              pageRedirect: ConstructionPage(),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomSignUpButton(
                              buttonColour: Color(0xFF951B81),
                              horizontalPadding: 60,
                              buttonText: 'Sign Up',
                              pageRedirect: ConstructionPage(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: null,
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue),
                                ))
                          ],
                        ),
                      ))
                ],
              ),
            )));
  }
}
