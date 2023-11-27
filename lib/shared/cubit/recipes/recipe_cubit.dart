// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/recipe_model.dart';
import '../../networks/remote/dio_helper.dart';
import '../../networks/remote/end_points.dart';
part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeCubitState> {
  RecipeCubit() : super(RecipeCubitInitial());
  static RecipeCubit get(context) => BlocProvider.of(context);

  List<dynamic> categoryRecipes = [];

  void getCategoryRecipes({
    required String id,
  }) {
    emit(GetCategoryRecipesLoading());
    DioHelper.getData(
      url: "${EndPoints.categories}/$id/${EndPoints.recipes}",
      jwt: token,
    ).then((value) {
      categoryRecipes =
          value.data["documents"].map((e) => RecipeModel.fromJson(e)).toList();
      emit(GetCategoryRecipesSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetCategoryRecipesError(errorMessage));
    });
  }

  RecipeModel? recipe;

  void getRecipe({
    required String id,
  }) {
    emit(GetRecipeLoading());
    DioHelper.getData(
      url: "${EndPoints.recipes}/$id",
      jwt: token,
    ).then((value) {
      recipe = RecipeModel.fromJson(value.data["document"]);
      emit(GetRecipeSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetRecipeError(errorMessage));
    });
  }
}
