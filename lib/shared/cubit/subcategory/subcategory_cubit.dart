// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/sub_category.dart';
import 'package:forkified/shared/networks/local/cache_helper.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
part 'subcategory_state.dart';

class SubcategoryCubit extends Cubit<SubcategoryState> {
  SubcategoryCubit() : super(SubcategoryInitial());
  static SubcategoryCubit get(context) => BlocProvider.of(context);

  List<dynamic>? subcategories = [];

  void getCategorySubcategories({
    required String id,
  }) {
    emit(GetCategorySubcategoriesLoading());
    DioHelper.getData(
      url: "${EndPoints.categories}/$id/${EndPoints.subcategories}",
      jwt: token,
    ).then((value) {
      subcategories =
          value.data["documents"].map((e) => SubCategory.fromJson(e)).toList();
      emit(GetCategorySubcategoriesSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetCategorySubcategoriesError(errorMessage));
    });
  }

  SubCategory? subcategory;

  void getSubCategory({
    required String id,
  }) {
    emit(GetSubCategoryLoading());
    DioHelper.getData(
      url: "${EndPoints.subcategories}/$id",
      jwt: token,
    ).then((value) {
      subcategory = SubCategory.fromJson(value.data["document"]);
      emit(GetSubCategorySuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetSubCategoryError(errorMessage));
    });
  }

  void addSubCategory({
    required String name,
    required String description,
    required String categoryId,
  }) {
    emit(AddSubCategoryLoadingState());
    DioHelper.postData(
        url: EndPoints.subcategories,
        jwt: token ?? CacheHelper.getData(key: "token"),
        data: {
          "name": name,
          "description": description,
          "category": categoryId,
        }).then((value) {
      emit(AddSubCategorySuccessState());
    }).catchError((error) {
      emit(AddSubCategoryErrorState());
    });
  }

  void updateSubCategory({
    required String name,
    required String description,
    required String categoryId,
    required String subcategoryId,
  }) {
    emit(UpdateSubCategoryLoadingState());
    DioHelper.updateData(
        url: "${EndPoints.subcategories}/$subcategoryId",
        jwt: token ?? CacheHelper.getData(key: "token"),
        data: {
          "name": name,
          "description": description,
          "category": categoryId,
        }).then((value) {
      emit(UpdateSubCategorySuccessState());
    }).catchError((error) {
      emit(UpdateSubCategoryErrorState());
    });
  }

   void deleteSubCategory({
    required String subcategoryId,
  }) {
    emit(DeleteSubCategoryLoadingState());
    DioHelper.deleteData(
        url: "${EndPoints.subcategories}/$subcategoryId",
        jwt: token ?? CacheHelper.getData(key: "token"),
        data: {

        }).then((value) {
      emit(DeleteSubCategorySuccessState());
    }).catchError((error) {
      emit(DeleteSubCategoryErrorState());
    });
  }
}
