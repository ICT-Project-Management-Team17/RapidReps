
import 'export.dart';


class SolicitorModel extends userModel {
  bool? freelancer;
  String? firm;
  String? experience;

  SolicitorModel(
      {uid,
      firstName,
      lastName,
      mobileNumber,
      telephoneNumber,
      email,
      userType,
      this.firm,
      this.freelancer,
      this.experience})
      : super(
            uid: uid,
            firstName: firstName,
            lastName: lastName,
            mobileNumber: mobileNumber,
            telephoneNumber: telephoneNumber,
            email: email,
            userType: userType);

  factory SolicitorModel.fromMap(map) {
    return SolicitorModel(
        uid: map['uid'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        mobileNumber: map['mobileNumber'],
        telephoneNumber: map['telephoneNumber'],
        email: map['email'],
        firm: map['firm'],
        freelancer: map['freelancer'],
        experience: map['experience'],
        userType: map['userType']);
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
      'freelancer': freelancer,
      'experience': experience,
      'userType': userType
    };
  }
}
