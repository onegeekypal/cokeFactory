import 'package:cokefactory/bloc/login_cubit.dart';
import 'package:cokefactory/bloc/login_state.dart';
import 'package:cokefactory/dashboard/dashboard.dart';
import 'package:cokefactory/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(create:(BuildContext context) => UserLoginCubit(),child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLoginCubit, UserLoginState >(
      builder: (context, state) {
        Widget screen;
        if(state is UserLoginInitialState)  screen = LoginForm();
        else if (state is UserLoginLoadingState) screen = CircularProgressIndicator();
        else screen = Dashboard();
        return Scaffold(
          body: Center(child: screen),
        );
      },
    );
  }
}
