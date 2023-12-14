part of 'categories_cubit.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

class ChangeBottomNavBarIndex extends CategoriesState {}

class GetCategoriesLoading extends CategoriesState {}

class GetCategoriesSuccess extends CategoriesState {}

class GetCategoriesError extends CategoriesState {
  final String error;
  GetCategoriesError(this.error);
}

class GetCategoryLoading extends CategoriesState {}

class GetCategorySuccess extends CategoriesState {}

class GetCategoryError extends CategoriesState {
  final String error;
  GetCategoryError(this.error);
}

class AddCategoryLoading extends CategoriesState {}

class AddCategorySuccess extends CategoriesState {}

class AddCategoryError extends CategoriesState {
  final String error;
  AddCategoryError(this.error);
}

class CategoryImagePickedFromGallerySuccessState extends CategoriesState {}

class CategoryImagePickedFromGalleryErrorState extends CategoriesState {}

class RemoveCategoryImageState extends CategoriesState {}

class RemoveNteworkImagestate extends CategoriesState {}

class UpdateCategoryLoading extends CategoriesState {}

class UpdateCategorySuccess extends CategoriesState {}

class UpdateCategoryError extends CategoriesState {
  final String error;
  UpdateCategoryError(this.error);
}

class DeleteCategoryLoading extends CategoriesState {}

class DeleteCategorySuccess extends CategoriesState {}

class DeleteCategoryError extends CategoriesState {
  final String error;
  DeleteCategoryError(this.error);
}
