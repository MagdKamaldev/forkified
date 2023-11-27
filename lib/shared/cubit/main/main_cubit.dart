// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/categories.model.dart';
import 'package:forkified/models/recipe_model.dart';
import 'package:forkified/models/sub_category.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
import '../../networks/local/cache_helper.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);

  void changemode(bool value) {  
            isDark = value;
            CacheHelper.saveData(key: "mode", value: isDark).then((value) {
              emit(ChangeAppMode());
            });
           }

  List<dynamic>? allCategories = [];

  void getAllCategories() {
    emit(GetAllCategoriesLoading());
    DioHelper.getData(url: EndPoints.categories, jwt: token).then((value) {
      allCategories = value.data["documents"]!
          .map((e) => CategoryModel.fromJson(e))
          .toList();
      emit(GetAllCategoriesSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetAllCategoriesError(errorMessage));
    });
  }

  List<dynamic>? allSubCategories = [];

  void getAllSubcategories() {
    emit(GetAllSubcategoriesLoading());
    DioHelper.getData(url: EndPoints.subcategories, jwt: token).then((value) {
      allSubCategories =
          value.data["documents"]!.map((e) => SubCategory.fromJson(e)).toList();
      emit(GetAllSubcategoriesSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetAllSubcategoriesError(errorMessage));
    });
  }

  List<dynamic>? allRecipes = [];
  void getAllRecipes() {
    emit(GetAllRecipesLoading());
    DioHelper.getData(url: EndPoints.recipes, jwt: token).then((value) {
      allRecipes =
          value.data["documents"]!.map((e) => RecipeModel.fromJson(e)).toList();
      emit(GetAllRecipesSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetAllRecipesError(errorMessage));
    });
  }
}
