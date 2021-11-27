import 'package:rapid_reps/models/user_model.dart';

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
  String? policeStation;

  CDOModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.telephoneNumber,
    this.email,
    this.userType,
    this.policeStation,
  });

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
      'polceStation': policeStation,
      'userType': userType
    };
  }
}
