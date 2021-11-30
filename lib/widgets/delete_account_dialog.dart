import 'package:flutter/material.dart';

Future<dynamic> deleteAccountDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("WARNING"),
        content: const Text("Completing this action will delete your account"),
        actions: [
          TextButton(
            child: const Text(
              "DELETE MY ACCOUNT",
            ),
            onPressed: () {
              Navigator.of(context).pop("Delete");
            },
          ),
          TextButton(
            child: const Text(
              "CANCEL",
            ),
            onPressed: () {
              Navigator.of(context).pop("Cancel");
            },
          )
        ],
      );
    },
  );
}
