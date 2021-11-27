<<<<<<< HEAD
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
=======
import 'package:rapid_reps/models/user_model.dart';

class SolicitorModel extends userModel {
>>>>>>> 0881e475b26e5fed32621c9d01b9e5751464a549
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
