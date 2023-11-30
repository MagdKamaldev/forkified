// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, unused_local_variable
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/recipe_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../components.dart';
import '../../networks/local/cache_helper.dart';
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

  List<dynamic> subcategoryRecipes = [];

  void getSubCategoryRecipes({
    required String id,
  }) {
    emit(GetCategoryRecipesLoading());
    DioHelper.getData(
      url: "${EndPoints.subcategories}/$id/${EndPoints.recipes}",
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

  File? recipeImage;
  var pickedFile;
  var picker = ImagePicker();

  Future<void> getrecipeImagefromGallery(context) async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      recipeImage = File(pickedFile.path);
      emit(RecipeImagePickedFromGallerySuccessState());
    } else {
      showCustomSnackBar(context, "no image selected", Colors.red);
      emit(RecipeImagePickedFromGalleryErrorState());
    }
  }

  void removeCategoryImage() {
    pickedFile = null;
    recipeImage = null;
    emit(RemoveRecipeImageState());
  }

  void addRecipe(
      {required String name,
      required String description,
      required List<dynamic> ingredients,
      required int prepTime,
      required int calories,
      required String category,
      required String subcategory,
      required bool vegeterien,
      required bool isdiet}) async {
    emit(AddRecipeLoadingState());

    String filename = pickedFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        pickedFile.path,
        filename: filename,
        contentType: MediaType('image', 'jpg'),
      ),
      "name": name,
      "description": description,
      "ingredients": ingredients,
      "prep_time": prepTime,
      "calories": calories,
      "category": category,
      "subcategory": subcategory,
      "vegetarian": vegeterien,
      "diet": isdiet ? "yes" : "no",
    });
    DioHelper.postData(
      url: EndPoints.recipes,
      jwt: token ?? CacheHelper.getData(key: "token"),
      data: formData,
    ).then((value) {
      emit(AddRecipeSuccessState());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(AddRecipeErrorState(errorMessage));
    });
  }

  File? updateImage;
  var updatepickedFile;
  var updatepicker = ImagePicker();

  Future<void> getUpdateImagefromGallery(context) async {
    updatepickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (updatepickedFile != null) {
      updateImage = File(updatepickedFile.path);
      emit(RecipeImagePickedFromGallerySuccessState());
    } else {
      showCustomSnackBar(context, "no image selected", Colors.red);
      emit(RecipeImagePickedFromGalleryErrorState());
    }
  }

  void removeUpdateImage() {
    updatepickedFile = null;
    updateImage = null;
    emit(RemoveRecipeImageState());
  }

  bool imageRemoved = false;

  void removenetworkImage() {
    imageRemoved = true;
    emit(RemoveNetworkImageState());
  }

  String? filename;
  FormData? formData;

  void updateRecipe({
    required String id,
    required String name,
    required String description,
    required int prepTime,
    required int calories,
    required List<dynamic> ingredients,
    required bool isvegan,
    required bool isDiet,
  }) async {
    emit(UpdateRecipeLoadingState());
    if (updateImage != null) {
      filename = updatepickedFile!.path.split('/').last;
      formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          updatepickedFile.path,
          filename: filename,
          contentType: MediaType('image', 'jpg'),
        ),
        "name": name,
        "description": description,
        "prep_time": prepTime,
        "calories": calories,
        "ingredients": ingredients,
        "vegetarian": isvegan,
        "diet": isDiet ? "yes" : "no",
      });
    }

    DioHelper.updateData(
      url: "${EndPoints.recipes}/$id",
      jwt: token ?? CacheHelper.getData(key: "token"),
      data: updateImage != null
          ? formData
          : imageRemoved
              ? {
                  "name": name,
                  "description": description,
                  "prep_time": prepTime,
                  "calories": calories,
                  "ingredients": ingredients,
                  "vegetarian": isvegan,
                  "diet": isDiet ? "yes" : "no",
                  "image": "",
                }
              : {
                  "name": name,
                  "description": description,
                  "prep_time": prepTime,
                  "calories": calories,
                  "ingredients": ingredients,
                  "vegetarian": isvegan,
                  "diet": isDiet ? "yes" : "no",
                },
    ).then((value) {
      removeUpdateImage();
      emit(UpdateRecipeSuccessState());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(UpdateRecipeErrorState(errorMessage));
    });
  }

  void deleteRecipe({
    required String id,
  }) {
    emit(DeleteRecipeLoadingState());
    DioHelper.deleteData(
      url: "${EndPoints.recipes}/$id",
      jwt: token,
      data: {},
    ).then((value) {
      emit(DeleteRecipeSuccessState());
    }).catchError((error) {
      emit(DeleteRecipeErrorState(error.toString()));
    });
  }
}
