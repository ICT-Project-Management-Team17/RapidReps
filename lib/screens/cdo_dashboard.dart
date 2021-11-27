import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reps/models/user_model.dart';
import 'package:rapid_reps/screens/export.dart';
import 'package:rapid_reps/utilities/constants.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class CDODashboard extends StatefulWidget {
  final userModel currentUser;

  const CDODashboard({Key? key, required this.currentUser}) : super(key: key);

  @override
  _CDODashboardState createState() => _CDODashboardState();
}

class _CDODashboardState extends State<CDODashboard> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard ${widget.currentUser.userType}'),
        centerTitle: true,
        backgroundColor: kCDOColour,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            const Center(
              child: Text("Jobs Page"),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.currentUser.firstName} ${widget.currentUser.lastName}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      "${widget.currentUser.email}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${widget.currentUser.mobileNumber}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${widget.currentUser.telephoneNumber}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
                child: Column(
              children: [
                const Text("Logout"),
                const SizedBox(
                  height: 15,
                ),
                ActionChip(
                  label: const Text("Logout"),
                  onPressed: () {
                    logout(context);
                  },
                ),
              ],
            )),
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
}
