part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

class GetUserDataLoading extends UserState {}

class GetUserDataSuccess extends UserState {}

class GetUserDataError extends UserState {
  final String errorMessage;
  GetUserDataError(this.errorMessage);
}
