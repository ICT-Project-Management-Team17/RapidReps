import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reps/models/export.dart';
import 'package:rapid_reps/services/export.dart';
import 'package:rapid_reps/utilities/export.dart';
import 'package:rapid_reps/widgets/export.dart';

// ignore: must_be_immutable
class ViewJobSolicitor extends StatefulWidget {
  QueryDocumentSnapshot currentJob;
  SolicitorModel? solicitor;
  late SolicitorModel currentUser;
  late bool registeredInterestQ;
  ViewJobSolicitor(
      {Key? key,
      required this.currentJob,
      this.solicitor,
      required this.currentUser,
      required this.registeredInterestQ})
      : super(key: key);

  @override
  _ViewJobSolicitorState createState() => _ViewJobSolicitorState();
}

class _ViewJobSolicitorState extends State<ViewJobSolicitor> {
  final int _currentIndex = 0;
  late PageController _pageController;
  late final String _jobType = widget.currentJob['jobType'];
  late String jobDes = widget.currentJob['jobDescription'];
  late TextEditingController jobDescriptionController =
      TextEditingController(text: jobDes);
  late QueryDocumentSnapshot curJob = widget.currentJob;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(widget.registeredInterestQ);
    return Scaffold(
      appBar: AppBar(
        title: Text('Job: ${widget.currentJob.id}'),
        centerTitle: true,
        backgroundColor: widget.currentJob['assignedSolicitor'] != null
            ? Colors.orange
            : kCDOColour,
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
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
                        items: kJobTypes
                            .map<DropdownMenuItem<String>>((String value) {
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
                                  borderRadius: BorderRadius.all(Radius.zero))),
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                              buttonColour: kCDOColour,
                              horizontalPadding: 100,
                              buttonText: widget.registeredInterestQ
                                  ? 'Withdraw Interest'
                                  : 'Register Interest',
                              onPressed: () async {
                                FirebaseFirestore firebaseFirestore =
                                    FirebaseFirestore.instance;
                                firebaseFirestore
                                    .collection('jobs')
                                    .doc(widget.currentJob.id)
                                    .update({
                                  'interestedSolicitors': FieldValue.arrayUnion(
                                      [widget.currentUser.uid])
                                });

                                firebaseFirestore
                                    .collection('jobs')
                                    .doc(widget.currentJob.id)
                                    .collection('interestedSolicitors')
                                    .doc('${widget.currentUser.uid}')
                                    .set({
                                  'uidSolicitor': widget.currentUser.uid
                                });
                                customToast(
                                  msg: 'Registered Interest',
                                  backgroundColor: Colors.green,
                                );
                                Navigator.of(context).pop();
                              }))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
