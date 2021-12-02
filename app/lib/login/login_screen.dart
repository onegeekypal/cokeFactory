import 'package:cokefactory/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cokefactory/main.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // final formKey = GlobalKey();

  final formKey = GlobalKey<FormState>();

  Widget _usernameField() {
    return TextFormField(
      decoration: InputDecoration(hintText: "Username"),
      validator: (value){
        if(value == "Admin" || value == "Viewer"){
          userType = value!;

        }else{
          return "Wrong Username";
        }
        return null;
      }
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(hintText: "Password"),
        validator: (value){
          if(value == "Admin1" || value == "Viewer1"){

          }else{
            return "Wrong Password";
          }
          return null;
        }
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
                if(formKey.currentState!.validate()){
                BlocProvider.of<UserLoginCubit>(context).loginUser(userType);}
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
