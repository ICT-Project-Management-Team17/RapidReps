import 'export.dart';

class FirmRep extends userModel {
  String? firm;

  FirmRep({
    uid,
    firstName,
    lastName,
    mobileNumber,
    telephoneNumber,
    email,
    userType,
    this.firm,
  }) : super(
            uid: uid,
            firstName: firstName,
            lastName: lastName,
            mobileNumber: mobileNumber,
            telephoneNumber: telephoneNumber,
            email: email,
            userType: userType);

  factory FirmRep.fromMap(map) {
    return FirmRep(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      mobileNumber: map['mobileNumber'],
      telephoneNumber: map['telephoneNumber'],
      email: map['email'],
      firm: map['address'],
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
      'firm': firm,
      'userType': userType
    };
  }
}
