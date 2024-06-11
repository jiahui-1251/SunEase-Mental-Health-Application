class UserModel {
  final String? UserID;
  final String UserName;
  final String email;
  final String password;

  const UserModel({
    this.UserID,
    required this.UserName,
    required this.email,
    required this.password,
  });

  toJson(){
    return {
      "UserID": UserID,
      "Email": email,
      "UserName": UserName,
      "Password": password,
    };
  }
}

