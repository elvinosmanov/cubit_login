class LoginResponseModel {
  String? token;
  LoginResponseModel({
    this.token,
  });

  LoginResponseModel.fromJson(json) {
    token = json["token"];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json;
    json = {"token": token};
    return json;
  }
}
