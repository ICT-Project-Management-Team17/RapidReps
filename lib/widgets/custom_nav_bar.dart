import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavBar extends StatefulWidget {
  int currentIndex;
  PageController controller;
  List<BottomNavyBarItem> navBarItems;
  CustomNavBar({
    Key? key,
    required this.currentIndex,
    required this.controller,
    required this.navBarItems,
  }) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: widget.currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        setState(() => widget.currentIndex = index);
        widget.controller.animateToPage(index,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.ease);
      },
      items: widget.navBarItems,
    );
  }
}
