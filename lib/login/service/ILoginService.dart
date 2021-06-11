import 'package:cubit_login/login/model/LoginRequestModel.dart';
import 'package:cubit_login/login/model/LoginResponseModel.dart';
import 'package:dio/dio.dart';

abstract class ILoginService {
  final Dio dio;

  ILoginService(this.dio);
  final loginPath = LoginServicePath.LOGIN.rawValue;
  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model);
}

enum LoginServicePath { LOGIN }

extension LoginServicePathExtension on LoginServicePath {
  String get rawValue {
    switch (this) {
      case LoginServicePath.LOGIN:
        return "/login";
    }
  }
}
