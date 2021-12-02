import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cokefactory/utils/user.dart';

import 'login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  String userRole = "";
  UserLoginCubit() : super(UserLoginInitialState());

  void loginUser(String userType) async {
    userRole = userType;
    emit(UserLoginLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(UserLoginFinishedState(
        user: User(username: "Dawid", userRole: userType == "Admin" ? UserRole.admin : UserRole.manager )));
  }
}
