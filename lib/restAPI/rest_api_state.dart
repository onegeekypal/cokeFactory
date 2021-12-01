part of 'rest_api_cubit.dart';

@immutable
abstract class RestApiState {}

class RestApiInitial extends RestApiState {}

class DataUpdatedState extends RestApiState{
  final DashboardData data;
  DataUpdatedState({required this.data});
}

