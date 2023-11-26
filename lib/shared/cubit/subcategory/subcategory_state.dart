part of 'subcategory_cubit.dart';

sealed class SubcategoryState {}

final class SubcategoryInitial extends SubcategoryState {}

class GetCategorySubcategoriesLoading extends SubcategoryState {}

class GetCategorySubcategoriesSuccess extends SubcategoryState {}

class GetCategorySubcategoriesError extends SubcategoryState {
  final String errorMessage;

  GetCategorySubcategoriesError(this.errorMessage);
}
