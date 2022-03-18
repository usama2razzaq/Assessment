class UserModel {
  String uid, fname, lname, mobileNo, email, dateofBirth;

  UserModel(
      {required this.uid,
      required this.fname,
      required this.lname,
      required this.mobileNo,
      required this.email,
      required this.dateofBirth});

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        fname: map['fname'],
        lname: map['lname'],
        mobileNo: map['mobileNo'],
        email: map['email'],
        dateofBirth: map['dateofBirth']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fname': fname,
      'lname': lname,
      'mobileNo': mobileNo,
      'email': email,
      'dateofBirth': dateofBirth,
    };
  }
}
