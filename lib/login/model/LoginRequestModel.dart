class LoginRequestModel {
  String? email;
  String? password;
  LoginRequestModel({
    this.email,
    this.password,
  });
  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json;
    json = {"email": email, "password": password};
    return json;
  }
}
