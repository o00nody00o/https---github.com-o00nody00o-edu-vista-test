class UserModel {
  int? id;
  String? fullname;
  String? password;
  String? email;

  UserModel(
      {required this.fullname,
      this.id,
      required this.password,
      required this.email});

  toJson() {
    return {
      "full name": fullname,
       "password": password,
        "email": email};
  }
}
