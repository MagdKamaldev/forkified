part of 'app_cubit.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

class GetCategoriesLoading extends AppState {}

class GetCategoriesSuccess extends AppState {}

class GetCategoriesError extends AppState {
  final String error;
  GetCategoriesError(this.error);
}

class GetCategoryLoading extends AppState {}
class GetCategorySuccess extends AppState {}
class GetCategoryError extends AppState {
  final String error;
  GetCategoryError(this.error);
}
