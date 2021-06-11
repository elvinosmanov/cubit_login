import 'package:cubit_login/login/service/login_service.dart';
import 'package:cubit_login/login/view/login_detail_view.dart';
import 'package:cubit_login/login/viewmodel/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String baseUrl = "https://reqres.in/api";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
          formKey, emailController, passwordController,
          service: LoginService(Dio(BaseOptions(baseUrl: baseUrl)))),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginCompletedState) {
            state.navigate(context);
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      appBar: AppBar(
        leading: Visibility(
            visible: context.watch<LoginCubit>().isLoading,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            )),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: autovalidateMode(state),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildEmailTextFormField(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            buildPasswordTextFormField(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            buildElevatedButtonLogin(context)
          ],
        ),
      ),
    );
  }

  Widget buildElevatedButtonLogin(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {},
      child: ElevatedButton.icon(
          onPressed: !context.watch<LoginCubit>().isLoading
              ? () {
                  context.read<LoginCubit>().postUserModel();
                }
              : null,
          icon: Icon(Icons.login),
          label: Text('Login')),
    );
  }

  AutovalidateMode autovalidateMode(LoginState state) {
    return state is LoginValidateState
        ? AutovalidateMode.always
        : AutovalidateMode.disabled;
  }

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
      controller: passwordController,
      validator: (value) => (value ?? "").length < 4
          ? "Please enter more than 4 character"
          : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Password",
      ),
    );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
      controller: emailController,
      autovalidateMode: AutovalidateMode.disabled,
      validator: (value) => (value ?? "").length < 6
          ? "Please enter more than 6 character"
          : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Email",
      ),
    );
  }
}

extension LoginCompleteStateExtension on LoginCompletedState {
  void navigate(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => LoginDetailView(model: model)));
  }
}
