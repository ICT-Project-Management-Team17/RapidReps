import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'export.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: widget.userColour),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
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
                    style: TextStyle(fontSize: 13),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.volume_up),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConstructionPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
