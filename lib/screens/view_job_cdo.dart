import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rapid_reps/models/export.dart';
import 'package:rapid_reps/utilities/export.dart';
import 'package:rapid_reps/widgets/export.dart';

// ignore: must_be_immutable
class ViewJobCDO extends StatefulWidget {
  QueryDocumentSnapshot currentJob;
  SolicitorModel? solicitor;
  ViewJobCDO({Key? key, required this.currentJob, required this.solicitor})
      : super(key: key);

  @override
  _ViewJobCDOState createState() => _ViewJobCDOState();
}

class _ViewJobCDOState extends State<ViewJobCDO> {
  int _currentIndex = 0;
  late PageController _pageController;
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
                              items: kJobTypes.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
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
                              height: 520,
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
                                        borderRadius:
                                            BorderRadius.all(Radius.zero))),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                  buttonColour: kCDOColour,
                                  horizontalPadding: 100,
                                  buttonText: 'Save Changes',
                                  onPressed: () {
                                    updateJob(_jobType,
                                        jobDescriptionController.text);
                                  }),
                            )
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
                          "Solicitor",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                          ),
                        ),
                        widget.currentJob['assignedSolicitor'] == null
                            ? Column(children: const [
                                Text(
                                  "No Solicitor Assigned",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //Text('FirstNAME: NULL')
                              ])
                            : Column(children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${widget.solicitor!.firstName?.capitalize()} ${widget.solicitor!.lastName?.capitalize()}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${widget.solicitor!.firm != null ? widget.solicitor!.firm : 'Freelancer'}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${widget.solicitor!.experience} Years of Experience",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${widget.solicitor!.mobileNumber}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${widget.solicitor!.email}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 24,
                                  ),
                                ),
                              ]),
                      ],
                    )),
              ),
            ]),
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

  Future<Column> getSolicitor() async {
    // ignore: unused_local_variable
    var document = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentJob['assignedSolicitor'])
        .get()
        .then((doc) {
      return Text('${doc.data()!['firstName']}');
    });

    return Column(
      children: const [
        Text(
          "No Solicitor Assigned",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  updateJob(String jobType, String jobDescription) async {
    if (_formKey.currentState!.validate()) {
      try {
        var collection = FirebaseFirestore.instance.collection('jobs');
        collection.doc(widget.currentJob.id).update({
          'jobType': jobType,
          'jobDescription': jobDescription,
        });
        Fluttertoast.showToast(
          msg: 'Updates Applied',
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        errorText = error.code;
        Fluttertoast.showToast(
          msg: errorText!,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }
}
