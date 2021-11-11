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
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFF009FE3),
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
                        "CDO Agreemant Page",
                        style: TextStyle(
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
