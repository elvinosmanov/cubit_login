import 'package:flutter/material.dart';

import 'package:cubit_login/login/model/LoginResponseModel.dart';

class LoginDetailView extends StatelessWidget {
  final LoginResponseModel model;
  const LoginDetailView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.token ?? ''),
      ),
    );
  }
}
