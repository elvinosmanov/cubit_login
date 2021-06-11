import 'dart:io';

import 'package:cubit_login/login/model/LoginResponseModel.dart';
import 'package:cubit_login/login/model/LoginRequestModel.dart';
import 'package:cubit_login/login/service/ILoginService.dart';
import 'package:dio/dio.dart';

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model) async {
    final response = await dio.post(loginPath, data: model);
    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.data);
    } else
      return null;
  }
}
