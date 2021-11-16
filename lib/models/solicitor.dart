class SolicitorModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? telephoneNumber;
  String? email;
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
