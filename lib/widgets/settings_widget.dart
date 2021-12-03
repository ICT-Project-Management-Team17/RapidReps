import 'package:flutter/material.dart';
import 'export.dart';
import '../screens/export.dart';
import '../services/export.dart';

class SettingsWidget extends StatelessWidget {
  final Color userColour;
  const SettingsWidget({
    Key? key,
    required this.userColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                backgroundColour: userColour,
                horizontalPadding: 25,
                icon: Icons.email,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeEmail(
                      userColor: userColour,
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
                      userColour: userColour,
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
    );
  }
}
