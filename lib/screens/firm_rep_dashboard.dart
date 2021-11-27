import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/export.dart';
import '../models/export.dart';
import 'export.dart';
import '../utilities/export.dart';

class FirmRepDashboard extends StatefulWidget {
  final userModel currentUser;

  const FirmRepDashboard({Key? key, required this.currentUser})
      : super(key: key);

  @override
  _FirmRepDashboardState createState() => _FirmRepDashboardState();
}

class _FirmRepDashboardState extends State<FirmRepDashboard> {
  int _currentIndex = 0;
  late PageController _pageController;
  late String? mobileNumber = widget.currentUser.mobileNumber;
  late String? telephoneNumber = widget.currentUser.telephoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard ${widget.currentUser.userType}'),
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
                    // when retreiving jobs, make them populate here?
                    Container(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConstructionPage(),
                            ),
                          );
                        },
                        child: const Icon(Icons.add),
                        backgroundColor: kCDOColour,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    // when retreiving jobs, make them populate here?
                    Container(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConstructionPage(),
                            ),
                          );
                        },
                        child: const Icon(Icons.add),
                        backgroundColor: kCDOColour,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
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
                        "${widget.currentUser.email}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      getMobileNumber(),
                      const SizedBox(
                        height: 25,
                      ),
                      getTelephoneNumber(),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        buttonColour: kCDOColour,
                        horizontalPadding: 60,
                        buttonText: 'Edit',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConstructionPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ActionChip(
                        label: const Text("Logout"),
                        onPressed: () {
                          logout(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
              'Jobs',
            ),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(
              Icons.location_pin
            ),
            title: const Text(
              'Map',
            ),
            activeColor: Colors.greenAccent,
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
              Icons.logout,
            ),
            title: const Text(
              'Logout',
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  getMobileNumber() {
    if (mobileNumber != null) {
      return Text(
        "$mobileNumber",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 32,
        ),
      );
    }
  }

  getTelephoneNumber() {
    if (telephoneNumber != null) {
      return Text(
        "$telephoneNumber",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 32,
        ),
      );
    }
  }
}
