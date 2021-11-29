
import 'export.dart';


class CDOModel extends userModel {
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
