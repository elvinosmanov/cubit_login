import 'package:bloc/bloc.dart';
import 'package:cubit_login/login/model/LoginRequestModel.dart';
import 'package:cubit_login/login/model/LoginResponseModel.dart';
import 'package:cubit_login/login/service/ILoginService.dart';
import 'package:flutter/cupertino.dart';

class LoginCubit extends Cubit<LoginState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final ILoginService service;
  bool isLoading = false;
  LoginCubit(this.formKey, this.emailController, this.passwordController,
      {required this.service})
      : super(LoginInitialState());
  // bool isLoginFail = false;

  Future<void> postUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _changeLoading();
      final data = await service.postUserLogin(LoginRequestModel(
          email: emailController.text, password: passwordController.text));
      if (data is LoginResponseModel) {
        emit(LoginCompletedState(data));
      } else {
        emit(LoginErrorState("Could not post data"));
      }
    } else {
      // isLoginFail = true;
      // emit(LoginValidateState(isLoginFail));
      emit(LoginValidateState());
    }
  }

  void _changeLoading() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);

}

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginCompletedState extends LoginState {
  final LoginResponseModel model;

  LoginCompletedState(this.model);
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  LoginLoadingState(this.isLoading);
}

class LoginValidateState extends LoginState {
  // final isValidate;

  // LoginValidateState(this.isValidate);
}
