import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rapid_reps/utilities/constants.dart';
import 'package:rapid_reps/widgets/export.dart';
import 'package:rapid_reps/models/export.dart';

class AddJobCDO extends StatefulWidget {
  late CDOModel currentUser;

  AddJobCDO({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  _AddJobCDOState createState() => _AddJobCDOState();
}

class _AddJobCDOState extends State<AddJobCDO> {
  late String _jobType = 'Select a Job Type';
  final TextEditingController jobDescriptionController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Job'),
        centerTitle: true,
        backgroundColor: kCDOColour,
      ),
      body: SingleChildScrollView(
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
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? type) {
                        setState(() {
                          _jobType = type!;
                        });
                      },
                      value: _jobType,
                      validator: (selection) {
                        if (selection == 'Select a Job Type') {
                          return 'Please select a Job Type';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 528,
                      child: TextFormField(
                        controller: jobDescriptionController,
                        validator: (description) {
                          if (description!.isEmpty) {
                            return 'The Job Description cannot be empty';
                          }
                          // if (!RegExp(r'^.{20,}$').hasMatch(description)) {
                          //   return "Enter a valid description (Min 20 chars)";
                          // }
                        },
                        onSaved: (description) {
                          jobDescriptionController.text = description!;
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
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                          buttonColour: kCDOColour,
                          horizontalPadding: 100,
                          buttonText: 'Add New Job',
                          onPressed: () {
                            addNewJob();
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addNewJob() async {
    JobCDOModel addJobModel = JobCDOModel();

    if (_formKey.currentState!.validate()) {
      try {
        User? user = _auth.currentUser;

        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

        addJobModel.jobType = _jobType;
        addJobModel.jobDescription = jobDescriptionController.text;
        addJobModel.policeStation = widget.currentUser.policeStation;
        addJobModel.dateCreated = DateTime.now();
        addJobModel.uidCDO = user!.uid;
        addJobModel.jobCompleted = false;
        addJobModel.assignedSolicitor = null;
        addJobModel.interestedSolicitors = [""];

        await firebaseFirestore.collection('jobs').add(addJobModel.toMap());
        Navigator.of(context).pop();
      } catch (error) {
        errorText = error.toString();
        Fluttertoast.showToast(
            msg: errorText!,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
