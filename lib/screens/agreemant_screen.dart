import 'package:flutter/material.dart';
import 'package:rapid_reps/utilities/constants.dart';
import '../widgets/export.dart';

class AgreemantScreen extends StatefulWidget {
  final Color userColour;
  final String imageLocation;

  const AgreemantScreen(
      {Key? key, required this.userColour, required this.imageLocation})
      : super(key: key);

  @override
  _AgreemantScreenState createState() => _AgreemantScreenState();
}

class _AgreemantScreenState extends State<AgreemantScreen> {
  var widgetList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(
              maxHeight: 150,
              maxWidth: 150,
            ),
            child: Image(
                image: AssetImage(
              widget.imageLocation,
            )),
          ),
          Center(
            child: Container(
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
                  children: [
                    const Text(
                      "Basic Terms",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(kTerms)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
