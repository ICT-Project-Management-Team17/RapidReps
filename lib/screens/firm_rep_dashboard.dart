import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:rapid_reps/screens/firm_rep_edit_profile.dart';
import 'package:rapid_reps/services/export.dart';
import '../models/export.dart';
import 'export.dart';
import '../utilities/export.dart';
import '../widgets/export.dart';

// ignore: must_be_immutable
class FirmRepDashboard extends StatefulWidget {
  late FirmRep currentUser;

  FirmRepDashboard({Key? key, required this.currentUser}) : super(key: key);

  @override
  _FirmRepDashboardState createState() => _FirmRepDashboardState();
}

class _FirmRepDashboardState extends State<FirmRepDashboard> {
  int _currentIndex = 0;
  late PageController _pageController;
  late String? mobileNumber = widget.currentUser.mobileNumber;
  late String? telephoneNumber = widget.currentUser.telephoneNumber;
  late String? firm = widget.currentUser.firm;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.currentUser.userType} Dashboard'),
          centerTitle: true,
          backgroundColor: kFirmRepColour,
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
                            //.where('uidCDO', isEqualTo: widget.currentUser.uid)
                            .orderBy('dateCreated', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final jobs = snapshot.data!.docs;
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
                                          const TextStyle(color: Colors.white),
                                    ),
                                    tileColor: doc['jobCompleted']
                                        ? Colors.green
                                        : Colors.red,
                                    subtitle: Text(doc['jobType'],
                                        style: TextStyle(
                                            color: Colors.grey.shade300)),
                                    trailing: const Icon(Icons.arrow_forward,
                                        color: Colors.white),
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
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewJobFirm(
                                                      currentJob: doc,
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
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "$firm",
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
                          backgroundColour: kFirmRepColour,
                          horizontalPadding: 35,
                          icon: Icons.edit,
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FirmRepEditProfile(
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
                                firm = widget.currentUser.firm;
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
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        customIconButton(
                          context,
                          label: 'Change Email',
                          backgroundColour: kFirmRepColour,
                          horizontalPadding: 25,
                          icon: Icons.email,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeEmail(
                                userColor: kFirmRepColour,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        customIconButton(
                          context,
                          label: 'Change Password',
                          backgroundColour: Colors.orange,
                          horizontalPadding: 25,
                          icon: Icons.password,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePassword(
                                userColour: kFirmRepColour,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        customIconButton(
                          context,
                          label: 'Logout',
                          backgroundColour: Colors.red,
                          horizontalPadding: 25,
                          icon: Icons.logout,
                          onPressed: () => logout(context),
                        ),
                      ],
                    ),
                  ),
                ),
              )
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
}
