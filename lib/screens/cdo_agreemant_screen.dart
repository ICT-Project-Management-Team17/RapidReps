import 'package:flutter/material.dart';

class CDOAgreemantScreen extends StatefulWidget {
  const CDOAgreemantScreen({Key? key}) : super(key: key);

  @override
  _CDOAgreemantScreenState createState() => _CDOAgreemantScreenState();
}

class _CDOAgreemantScreenState extends State<CDOAgreemantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 120.0),
                  child: Text(
                    "THIS IS THE CDO AGREEMANT PAGE WHICH IS CURRENTLY UDNER CONSTRUCTION",
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
