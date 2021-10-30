import 'package:flutter/material.dart';

class ConstructionPage extends StatefulWidget {
  const ConstructionPage({Key? key}) : super(key: key);

  @override
  _ConstructionPageState createState() => _ConstructionPageState();
}

class _ConstructionPageState extends State<ConstructionPage> {
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
                    "THIS PAGE IS UNDER CONSTRUCTION",
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
