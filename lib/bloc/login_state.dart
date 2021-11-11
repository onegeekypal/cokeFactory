
import 'package:cokefactory/utils/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserLoginState extends Equatable {}

class UserLoginInitialState extends UserLoginState {
  @override
  List<Object> get props => [];
}

class UserLoginLoadingState extends UserLoginState {
  @override
  List<Object> get props => [];
}

class UserLoginFinishedState extends UserLoginState {
  final User user;
  UserLoginFinishedState({required this.user});

  @override
  List<Object> get props => [user];
}
