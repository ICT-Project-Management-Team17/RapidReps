import 'package:flutter/material.dart';
import 'export.dart';
import '../widgets/export.dart';

class CDOSignUpScreen extends StatefulWidget {
  final Color userColour;
  const CDOSignUpScreen({
    Key? key,
    required this.userColour,
  }) : super(key: key);

  @override
  _CDOSignUpScreenState createState() => _CDOSignUpScreenState();
}

class _CDOSignUpScreenState extends State<CDOSignUpScreen> {
  late String _policeStation = 'Select a Police Station';

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
      body: SingleChildScrollView(
        child: Column(
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
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Firstname',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Lastname',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Telephone Number',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Confirm Email',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButton<String>(
                      value: _policeStation,
                      icon: const Icon(
                        Icons.arrow_downward,
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      items: <String>[
                        'West Wickham Police Office   BR4 0LP',
                        'Croydon Police Station   CR0 6SR',
                        'Berlin Underwood House   CR20 2XR'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text(
                        "Select a Police Station",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _policeStation = value as String;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonColour: widget.userColour,
              horizontalPadding: 25,
              buttonText: 'Submit',
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
      ),
    );
  }
}
