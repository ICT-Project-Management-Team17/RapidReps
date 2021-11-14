import 'package:flutter/material.dart';
import 'export.dart';
import '../widgets/export.dart';

class SolicitorSignUpScreen extends StatefulWidget {
  final Color userColour;
  const SolicitorSignUpScreen({
    Key? key,
    required this.userColour,
  }) : super(key: key);

  @override
  _SolicitorSignUpScreenState createState() => _SolicitorSignUpScreenState();
}

class _SolicitorSignUpScreenState extends State<SolicitorSignUpScreen> {
  String _firm = 'Firm 1';
  bool isChecked = false;

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
                      height: 10,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Lastname',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Telephone Number',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Confirm Email',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CheckboxListTile(
                      title: const Text('I am a freelance solicitor'),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value as bool;
                        });
                      },
                    ),
                    Visibility(
                      visible: !isChecked,
                      child: DropdownButton<String>(
                        hint: const Text(
                          "Select a Firm",
                        ),
                        icon: const Icon(
                          Icons.arrow_downward,
                        ),
                        isExpanded: true,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        items: <String>['Firm 1', 'Firm 2', 'Firm 3']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _firm = value as String;
                          });
                        },
                        value: _firm,
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Amount of experience',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ),
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
