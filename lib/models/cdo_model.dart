class CDOModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? telephoneNumber;
  String? email;
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
