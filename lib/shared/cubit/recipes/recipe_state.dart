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

class AddRecipeLoadingState extends RecipeCubitState {}

class AddRecipeSuccessState extends RecipeCubitState {}

class AddRecipeErrorState extends RecipeCubitState {
  final String error;
  AddRecipeErrorState(this.error);
}

class RecipeImagePickedFromGallerySuccessState extends RecipeCubitState {}

class RecipeImagePickedFromGalleryErrorState extends RecipeCubitState {}

class RemoveRecipeImageState extends RecipeCubitState {}

class UpdateRecipeLoadingState extends RecipeCubitState {}

class UpdateRecipeSuccessState extends RecipeCubitState {}

class UpdateRecipeErrorState extends RecipeCubitState {
  final String error;
  UpdateRecipeErrorState(this.error);
}

class DeleteRecipeLoadingState extends RecipeCubitState {}

class DeleteRecipeSuccessState extends RecipeCubitState {}

class DeleteRecipeErrorState extends RecipeCubitState {
  final String error;
  DeleteRecipeErrorState(this.error);
}

class RemoveNetworkImageState extends RecipeCubitState {}

class GetReviewLoadingState extends RecipeCubitState {}

class GetReviewSuccessState extends RecipeCubitState {}

class GetReviewErrorState extends RecipeCubitState {
  final String error;
  GetReviewErrorState(this.error);
}

class AddReviewLoadingState extends RecipeCubitState {}

class AddReviewSuccessState extends RecipeCubitState {}

class AddReviewErrorState extends RecipeCubitState {
  final String error;
  AddReviewErrorState(this.error);
}

