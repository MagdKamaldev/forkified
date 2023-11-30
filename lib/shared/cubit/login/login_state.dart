part of '../login/login_cubit.dart';

sealed class LoginStates {}

final class LoginInitial extends LoginStates {}

final class LoginLoading extends LoginStates {}

final class LoginSuccess extends LoginStates {}

final class LoginError extends LoginStates {
  final String error;
  LoginError(this.error);
}

class SignInWithGoogleLoadingState extends LoginStates {}

class SignInWithGoogleSuccesState extends LoginStates {}

class SignInWithGoogleErrorState extends LoginStates {}

class SignInWithFacebookLoadingState extends LoginStates {}

class SignInWithFacebookErrorState extends LoginStates {}

class ChangePasswordVisibilityState  extends LoginStates {}