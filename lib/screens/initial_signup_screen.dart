import 'package:flutter/material.dart';
import '../widgets/export.dart';
import 'export.dart';

class InitialSignUpScreen extends StatefulWidget {
  const InitialSignUpScreen({Key? key}) : super(key: key);

  @override
  _InitialSignUpScreenState createState() => _InitialSignUpScreenState();
}

class _InitialSignUpScreenState extends State<InitialSignUpScreen> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 36.0,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        buttonColour: const Color(0xFF009FE3),
                        horizontalPadding: 70,
                        buttonText: 'CDO',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AgreemantScreen(
                                userColour: Color(0xFF009FE3),
                                imageLocation:
                                    'assets/images/police officer image.jpg',
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        buttonColour: const Color(0xFF009B14),
                        horizontalPadding: 60,
                        buttonText: 'Solicitor',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AgreemantScreen(
                                userColour: Color(0xFF009B14),
                                imageLocation: 'assets/images/lawyer.png',
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        buttonColour: const Color(0xFF951B81),
                        horizontalPadding: 10,
                        buttonText: 'Firm Representative',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AgreemantScreen(
                                userColour: Color(0xFF951B81),
                                imageLocation: 'assets/images/firm.png',
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        buttonColour: const Color(0xFFE30613),
                        horizontalPadding: 50,
                        buttonText: 'Back',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
