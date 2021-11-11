import 'package:flutter/material.dart';

class CDOAgreemantPage extends StatefulWidget {
  const CDOAgreemantPage({Key? key}) : super(key: key);

  @override
  _CDOAgreemantPageState createState() => _CDOAgreemantPageState();
}

class _CDOAgreemantPageState extends State<CDOAgreemantPage> {
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
