import 'export.dart';

class SolicitorModel extends userModel {
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
  bool? freelancer;
  String? firm;
  String? experience;

  SolicitorModel(
      {this.uid,
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.telephoneNumber,
      this.email,
      this.userType,
      this.firm,
      this.freelancer,
      this.experience});

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
