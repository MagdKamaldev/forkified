part of 'recipe_cubit.dart';

sealed class RecipeCubitState {}

final class RecipeCubitInitial extends RecipeCubitState {}

class GetCategoryRecipesLoading extends RecipeCubitState {}

class GetCategoryRecipesSuccess extends RecipeCubitState {}

class GetCategoryRecipesError extends RecipeCubitState {
  final String error;
  GetCategoryRecipesError(this.error);
}

class GetRecipeLoading extends RecipeCubitState {}

class GetRecipeSuccess extends RecipeCubitState {}

class GetRecipeError extends RecipeCubitState {
  final String error;
  GetRecipeError(this.error);
}
