part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupError extends SignupState {
  final String errorMessage;

  SignupError(this.errorMessage);
}

class SignUpWithGoogleLoadingState extends SignupState {}

class SignUpWithGoogleSuccesState extends SignupState {}

class SignUpWithGoogleErrorState extends SignupState {}

class SignUpWithFacebookLoadingState extends SignupState {}

class SignUpWithFacebookErrorState extends SignupState {}

class ChangePasswordVisibilityState extends SignupState {}
