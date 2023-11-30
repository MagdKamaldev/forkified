part of 'subcategory_cubit.dart';

sealed class SubcategoryState {}

final class SubcategoryInitial extends SubcategoryState {}

class GetCategorySubcategoriesLoading extends SubcategoryState {}

class GetCategorySubcategoriesSuccess extends SubcategoryState {}

class GetCategorySubcategoriesError extends SubcategoryState {
  final String errorMessage;

  GetCategorySubcategoriesError(this.errorMessage);
}

class GetSubCategoryLoading extends SubcategoryState {}

class GetSubCategorySuccess extends SubcategoryState {}

class GetSubCategoryError extends SubcategoryState {
  final String errorMessage;

  GetSubCategoryError(this.errorMessage);
}

class AddSubCategoryLoadingState extends SubcategoryState{}

class AddSubCategorySuccessState extends SubcategoryState{}

class AddSubCategoryErrorState extends SubcategoryState{}
