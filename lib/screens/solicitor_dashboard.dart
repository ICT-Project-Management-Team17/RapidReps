// ignore_for_file: file_names

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapid_reps/services/export.dart';
import '../models/export.dart';
import 'export.dart';
import '../utilities/export.dart';
import '../widgets/export.dart';
import 'dart:async';

// ignore: must_be_immutable
class SolicitorDashboard extends StatefulWidget {
  late SolicitorModel currentUser;

  SolicitorDashboard({Key? key, required this.currentUser}) : super(key: key);

  @override
  _SolicitorDashboardState createState() => _SolicitorDashboardState();
}

class _SolicitorDashboardState extends State<SolicitorDashboard> {
  bool registeredInterest = false;
  int _currentIndex = 0;
  late PageController _pageController;
  late bool? freelance = widget.currentUser.freelancer;
  late String? mobileNumber = widget.currentUser.mobileNumber;
  late String? telephoneNumber = widget.currentUser.telephoneNumber;
  late CameraPosition currentPosition;
  late GoogleMapController newGoogleMapController;
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _startPos = CameraPosition(
    target: LatLng(51.49814, -0.10154),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    getCurrentPosition().whenComplete(() {
      setState(() {});
    });
    _pageController = PageController();
  }

  @override
  void dispose() {
    newGoogleMapController.dispose();
    super.dispose();
  }

  getCurrentPosition() async {
    try {
      currentPosition = await Maps().locatePosition();
      newGoogleMapController.animateCamera(
        CameraUpdate.newCameraPosition(currentPosition),
      );
    } catch (e) {
      customToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.currentUser.userType} Dashboard'),
          centerTitle: true,
          backgroundColor: kSolicitorColour,
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('jobs')
                            .where('jobCompleted', isEqualTo: false)
                            // .where('assignedSolicitor', isNull: true)
                            .orderBy('dateCreated', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final jobs = snapshot.data!.docs;
                            jobs.removeWhere((element) =>
                                element['assignedSolicitor'] != null &&
                                element['assignedSolicitor'] !=
                                    widget.currentUser.uid);
                            jobs.sort((a, b) {
                              return a['jobCompleted']
                                  .toString()
                                  .compareTo(b['jobCompleted'].toString());
                            });
                            return ListView(
                              primary: false,
                              shrinkWrap: true,
                              children: jobs.map((doc) {
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      doc.id,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    tileColor: doc['assignedSolicitor'] ==
                                            widget.currentUser.uid
                                        ? Colors.orange
                                        : Colors.white,
                                    subtitle: Text(
                                      doc['jobType'],
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward,
                                    ),
                                    onTap: () {
                                      SolicitorModel? solUser;
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(doc['assignedSolicitor'])
                                          .get()
                                          .then((solicitor) {
                                        if (solicitor.data() != null) {
                                          solUser = SolicitorModel.fromMap(
                                              solicitor.data());
                                        }
                                        // bool registeredInterest = false;
                                        // checkIfInterested(doc);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewJobSolicitor(
                                                      currentJob: doc,
                                                      solicitor: solUser,
                                                      currentUser:
                                                          widget.currentUser,
                                                      registeredInterestQ:
                                                          checkIfInterested(
                                                              doc),
                                                    )));
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        // display map here
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 500,
                            maxWidth: 900,
                          ),
                          child: GoogleMap(
                            initialCameraPosition: _startPos,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            onMapCreated: (GoogleMapController controller) {
                              if (!_controller.isCompleted) {
                                _controller.complete(controller);
                                newGoogleMapController = controller;
                                getCurrentPosition();
                              }
                            },
                            gestureRecognizers: <
                                Factory<OneSequenceGestureRecognizer>>{
                              Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer(),
                              ),
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ConstructionPage(),
                                ),
                              );
                            },
                            child: const Icon(Icons.list),
                            backgroundColor: kSolicitorColour,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "${widget.currentUser.firstName?.capitalize()} ${widget.currentUser.lastName?.capitalize()}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                          ),
                        ),
                        Visibility(
                          visible: freelance!,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              getFirmDetails(
                                freelance,
                                widget.currentUser.firm,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Experience: ${widget.currentUser.experience} years",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                          ),
                        ),
                        Visibility(
                          visible: mobileNumber != null,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              getNumber(mobileNumber),
                              const SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: telephoneNumber != null,
                          child: Column(
                            children: [
                              getNumber(telephoneNumber),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${widget.currentUser.email}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        customIconButton(
                          context,
                          label: 'Edit',
                          backgroundColour: kSolicitorColour,
                          horizontalPadding: 35,
                          icon: Icons.edit,
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SolicitorEditProfile(
                                  currentUser: widget.currentUser,
                                ),
                              ),
                            );
                            setState(() {
                              if (result != null) {
                                widget.currentUser = result;
                                mobileNumber = widget.currentUser.mobileNumber;
                                telephoneNumber =
                                    widget.currentUser.telephoneNumber;
                                freelance = widget.currentUser.freelancer;
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        customIconButton(
                          context,
                          label: 'Delete Account',
                          backgroundColour: Colors.red,
                          horizontalPadding: 25,
                          icon: Icons.delete_forever,
                          onPressed: () async {
                            var action = await deleteAccountDialog(context);
                            if (action != "Cancel" &&
                                action != null &&
                                action != "") {
                              var result = await AuthService()
                                  .deleteUser(widget.currentUser.email, action);
                              if (result == true) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RedirectToLoginScreen(
                                              textToDisplay: 'Account Deleted',
                                            )));
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SettingsWidget(
                userColour: kSolicitorColour,
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
                'Jobs Taken',
              ),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.location_pin,
              ),
              title: const Text(
                'Map',
              ),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.people,
              ),
              title: const Text(
                'Profile',
              ),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.settings,
              ),
              title: const Text(
                'Settings',
              ),
              activeColor: Colors.grey,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  bool checkIfInterested(doc) {
    bool interested = false;
    FirebaseFirestore.instance
        .collection('jobs')
        .doc(doc.id)
        .collection('interestedSolicitors')
        .doc(widget.currentUser.uid)
        .get()
        .then((snapshot) => {
              interested = true,
            });
    return interested;
  }
}
