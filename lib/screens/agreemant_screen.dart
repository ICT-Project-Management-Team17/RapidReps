import 'package:flutter/material.dart';

class AgreemantScreen extends StatefulWidget {
  final Color userColour;
  const AgreemantScreen(
      {Key? key, required this.userColour})
      : super(key: key);

  @override
  _AgreemantScreenState createState() => _AgreemantScreenState();
}

class _AgreemantScreenState extends State<AgreemantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  child: Column(
                    children: const [
                      Text(
                        "Basic Terms",
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                       SizedBox(
                        height: 25,
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
