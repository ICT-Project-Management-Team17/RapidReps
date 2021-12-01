import 'package:flutter/material.dart';

Future<dynamic> deleteAccountDialog(BuildContext context) {
  final TextEditingController passwordController = TextEditingController();
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("WARNING"),
        content: TextFormField(
          controller: passwordController,
          validator: (password) {
            // RegExp regex = RegExp(r'^.{6,}$');
            if (password!.isEmpty) {
              return 'A Password is required to login';
            }
            if (!RegExp(r'^.{6,}$').hasMatch(password)) {
              return "Enter a valid password (Min 6 chars)";
            }
          },
          obscureText: true,
          textInputAction: TextInputAction.done,
          onSaved: (password) {
            passwordController.text = password!;
          },
          decoration: const InputDecoration(
              hintText: 'Password', hintStyle: TextStyle(color: Colors.grey)),
        ),
        actions: [
          TextButton(
            child: const Text(
              "DELETE MY ACCOUNT",
            ),
            onPressed: () {
              Navigator.of(context).pop(passwordController.text);
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
