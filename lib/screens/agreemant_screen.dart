import 'package:flutter/material.dart';
import '../utilities/export.dart';
import 'export.dart';
import '../widgets/export.dart';
import '../services/custom_tts.dart';

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
  final CustomTTS flutterTts = CustomTTS();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        flutterTts.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: widget.userColour),
            onPressed: () {
              flutterTts.stop();
              Navigator.pop(context, false);
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
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
                      Text(
                        kTerms,
                        style: const TextStyle(fontSize: 13),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              flutterTts.getSpeaking()
                                  ? flutterTts.stop()
                                  : flutterTts.speak(kTerms);
                            });
                          },
                          child: Icon(flutterTts.getSpeaking()
                              ? Icons.stop
                              : Icons.volume_up),
                          backgroundColor: widget.userColour,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                buttonColour: widget.userColour,
                horizontalPadding: 25,
                buttonText: 'Agree & Continue',
                onPressed: () {
                  if (widget.userColour == kCDOColour) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CDOSignUpScreen(
                          userColour: widget.userColour,
                        ),
                      ),
                    );
                  } else if (widget.userColour == kSolicitorColour) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SolicitorSignUpScreen(
                            userColour: widget.userColour),
                      ),
                      // solicitor sign up form
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FirmRepSignUpScreen(userColour: widget.userColour),
                      ),
                      // firm rep sign up form
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
