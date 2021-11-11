import 'package:cokefactory/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey();

  Widget _usernameField() {
    return TextFormField(
      decoration: InputDecoration(hintText: "Username"),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(hintText: "Password"),
    );
  }

  Widget _buttonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            "Clear",
            style: TextStyle(color: Colors.red),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<UserLoginCubit>(context).loginUser();
            },
            child: Text("Login")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 500),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _usernameField(),
            SizedBox(
              height: 20,
            ),
            _passwordField(),
            SizedBox(
              height: 20,
            ),
            _buttonRow(context),
          ],
        ),
      ),
    );
  }
}
