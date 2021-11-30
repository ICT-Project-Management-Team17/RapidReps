import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'export.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future deleteUser(String? email, String password) async {
    try {
      var user = await _auth.currentUser!;
      AuthCredential credentials = EmailAuthProvider.credential(
          email: email.toString(), password: password);
      var result = await user.reauthenticateWithCredential(credentials);
      await DatabaseService(uid: result.user!.uid)
          .deleteuser(); // called from database class
      await result.user!.delete();
      return true;
    } on FirebaseAuthException catch (error) {
      String errorText = error.code;
      if (errorText == 'too-many-requests') {
        errorText = 'Too many requests have been sent, please try again later';
      } else if (errorText == 'wrong-password') {
        errorText = 'Password was incorrect, please try again';
      }
      customToast(
        msg: errorText,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }
}
