part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

class GetUserDataLoading extends UserState {}

class GetUserDataSuccess extends UserState {}

class GetUserDataError extends UserState {
  final String errorMessage;
  GetUserDataError(this.errorMessage);
}

class AddRecipeToCollectionLoading extends UserState {}

class  AddRecipeToCollectionSuccess extends UserState {}

class  AddRecipeToCollectionError extends UserState {
  final String errorMessage;
  AddRecipeToCollectionError(this.errorMessage);
}

class DeleteRecipeFromCollectionLoading extends UserState {}

class  DeleteRecipeFromCollectionSuccess extends UserState {}

class  DeleteRecipeFromCollectionError extends UserState {
  final String errorMessage;
  DeleteRecipeFromCollectionError(this.errorMessage);
}