import 'dart:ffi';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reps/models/export.dart';
import 'package:rapid_reps/utilities/export.dart';
import 'package:rapid_reps/widgets/export.dart';

import 'export.dart';

class ViewJobFirm extends StatefulWidget {
  QueryDocumentSnapshot currentJob;
  ViewJobFirm({Key? key, required this.currentJob}) : super(key: key);

  @override
  _ViewJobFirmState createState() => _ViewJobFirmState();
}

class _ViewJobFirmState extends State<ViewJobFirm> {
  int _currentIndex = 0;
  late PageController _pageController;
  late List interestedSolicitors = widget.currentJob['interestedSolicitors'];
  late String _jobType = widget.currentJob['jobType'];
  late String jobDes = widget.currentJob['jobDescription'];
  late TextEditingController jobDescriptionController =
      TextEditingController(text: jobDes);
  late QueryDocumentSnapshot curJob = widget.currentJob;

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job: ${widget.currentJob.id}'),
        centerTitle: true,
        backgroundColor:
            widget.currentJob['jobCompleted'] ? Colors.green : Colors.red,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            hint: const Text(
                              "Select a Job Type",
                            ),
                            icon: const Icon(
                              Icons.arrow_downward,
                            ),
                            isExpanded: true,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                            items: <String>[
                              'Select a Job Type',
                              'Burglary',
                              'Childhood abuse',
                              'Crime abroad',
                              'Cyber crime and online fraud',
                              'Domestic abuse',
                              'Fraud',
                              'Hate crime',
                              'Murder or manslaughter',
                              'Robbery',
                              'Sexual harassment',
                              'Stalking and harassment',
                              'Terrorism',
                              'Violent crime'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: null,
                            value: _jobType,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              'Police Station: ${widget.currentJob['policeStation']}'),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 520,
                            child: TextFormField(
                              enabled: false,
                              controller: jobDescriptionController,
                              validator: (description) {
                                if (description!.isEmpty) {
                                  return 'The Job Description cannot be empty';
                                }
                                // if (!RegExp(r'^.{20,}$').hasMatch(description)) {
                                //   return "Enter a valid description (Min 20 chars)";
                                // }
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: 22,
                              decoration: const InputDecoration(
                                  alignLabelWithHint: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Job Description',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero))),
                            ),
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                  buttonColour: Colors.red,
                                  horizontalPadding: 100,
                                  buttonText: 'Back',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Interested Solicitors",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('uid', whereIn: interestedSolicitors)
                            // .where('assignedSolicitor', isNull: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (snapshot.data!.docs.length == 0) {
                              return const Text('No Interested Solicitors');
                            } else {
                              return ListView(
                                primary: false,
                                shrinkWrap: true,
                                children: snapshot.data!.docs.map((doc) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(
                                        '${doc['firstName']} ${doc['lastName']}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        doc['email'],
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward,
                                      ),
                                      onTap: () {},
                                    ),
                                  );
                                }).toList(),
                              );
                            }
                          }
                        },
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(index,
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.ease);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(
              Icons.apps,
            ),
            title: const Text(
              'Job',
            ),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(
              Icons.people,
            ),
            title: const Text(
              'Solicitor',
            ),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
