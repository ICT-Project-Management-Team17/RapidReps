class FirmRep {
  String? uid;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? telephoneNumber;
  String? email;
  String? userType;
  String? firm;

  FirmRep({
    this.uid,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.telephoneNumber,
    this.email,
    this.userType,
    this.firm,
  });

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
