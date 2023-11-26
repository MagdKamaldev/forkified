part of 'main_cubit.dart';

sealed class MainState {}

final class MainInitial extends MainState {}

class GetAllCategoriesLoading extends MainState {}

class GetAllCategoriesSuccess extends MainState {}

class GetAllCategoriesError extends MainState {
  final String error;
  GetAllCategoriesError(this.error);
}

class GetAllSubcategoriesLoading extends MainState {}

class GetAllSubcategoriesSuccess extends MainState {}

class GetAllSubcategoriesError extends MainState {
  final String error;
  GetAllSubcategoriesError(this.error);
}