<<<<<<< HEAD
import 'export.dart';

class CDOModel extends userModel {
  @override
  String? uid;
  @override
  String? firstName;
  @override
  String? lastName;
  @override
  String? mobileNumber;
  @override
  String? telephoneNumber;
  @override
  String? email;
  @override
  String? userType;
=======
import 'package:rapid_reps/models/user_model.dart';

class CDOModel extends userModel {
>>>>>>> 0881e475b26e5fed32621c9d01b9e5751464a549
  String? policeStation;

  CDOModel({
    uid,
    firstName,
    lastName,
    mobileNumber,
    telephoneNumber,
    email,
    userType,
    this.policeStation,
  }) : super(
            uid: uid,
            firstName: firstName,
            lastName: lastName,
            mobileNumber: mobileNumber,
            telephoneNumber: telephoneNumber,
            email: email,
            userType: userType);

  factory CDOModel.fromMap(map) {
    return CDOModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      mobileNumber: map['mobileNumber'],
      telephoneNumber: map['telephoneNumber'],
      email: map['email'],
      policeStation: map['policeStation'],
      userType: map['userType'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'telephoneNumber': telephoneNumber,
      'email': email,
      'policeStation': policeStation,
      'userType': userType
    };
  }
}
