// ignore_for_file: deprecated_member_use, unused_local_variable, prefer_typing_uninitialized_variables
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/models/categories.model.dart';
import 'package:forkified/modules/home/add_collection_screen.dart';
import 'package:forkified/modules/home/home_screen.dart';
import 'package:forkified/modules/home/user_screen.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../main.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial()) {
    getCategories();
  }
  static CategoriesCubit get(context) => BlocProvider.of(context);

  DateTime currentDateTime = DateTime.now();
  String? welcomeText;
  void selectWelcomeTime() {
    if (currentDateTime.hour < 12) {
      welcomeText = "Morning";
    } else if (currentDateTime.hour < 18) {
      welcomeText = "Afternoon";
    } else {
      welcomeText = "Evening";
    }
  }

  int bottomNavBarIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    AddCollectionScreen(),
    const UserScreen(),
  ];

  void changeIndex(int index) {
    bottomNavBarIndex = index;
    if (index == 0) {
      getCategories();
    }
    emit(ChangeBottomNavBarIndex());
  }

  List<dynamic> categories = [];

  void getCategories() {
    emit(GetCategoriesLoading());
    DioHelper.getData(
      url: EndPoints.categories,
      jwt: token,
    ).then((value) {
      categories = value.data["documents"]!
          .map((e) => CategoryModel.fromJson(e))
          .toList();
      emit(GetCategoriesSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetCategoriesError(errorMessage));
    });
  }

  CategoryModel? category;

  Future getCategory({
    required String id,
  }) {
    emit(GetCategoryLoading());
    DioHelper.getData(
      url: "${EndPoints.categories}/$id",
      jwt: token,
    ).then((value) {
      category = CategoryModel.fromJson(value.data["document"]);
      emit(GetCategorySuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetCategoryError(errorMessage));
    });
    return Future.value(category);
  }

  File? categoryImage;
  var pickedFile;
  var picker = ImagePicker();

  Future<void> getCategoryImagefromGallery(context) async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      categoryImage = File(pickedFile.path);
      emit(CategoryImagePickedFromGallerySuccessState());
    } else {
      showCustomSnackBar(context, "no image selected", Colors.red);
      emit(CategoryImagePickedFromGalleryErrorState());
    }
  }

  void removeCategoryImage() {
    pickedFile = null;
    categoryImage = null;
    emit(RemoveCategoryImageState());
  }

  void addCategory({
    required String name,
    required String description,
  }) async {
    emit(AddCategoryLoading());
    String filename = pickedFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        pickedFile.path,
        filename: filename,
        contentType: MediaType('image', 'jpg'),
      ),
      "name": name,
      "description": description,
    });
    DioHelper.postData(
      url: EndPoints.categories,
      jwt: token,
      data: formData,
    ).then((value) {
      getCategories();
      removeCategoryImage();
      emit(AddCategorySuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(AddCategoryError(errorMessage));
    });
  }

  File? updateImage;
  var updatepickedFile;
  var updatepicker = ImagePicker();

  Future<void> getUpdateImagefromGallery(context) async {
    updatepickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (updatepickedFile != null) {
      updateImage = File(updatepickedFile.path);
      emit(CategoryImagePickedFromGallerySuccessState());
    } else {
      showCustomSnackBar(context, "no image selected", Colors.red);
      emit(CategoryImagePickedFromGalleryErrorState());
    }
  }

  void removeUpdateImage() {
    updatepickedFile = null;
    updateImage = null;
    emit(RemoveCategoryImageState());
  }

  bool imageRemoved = false;

  void removenetworkImage() {
    imageRemoved = true;
    emit(RemoveNteworkImagestate());
  }

  String? filename;
  FormData? formData;
  void updateCategory({
    required String id,
    required String name,
    required String description,
  }) async {
    emit(UpdateCategoryLoading());
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
      });
    }

    DioHelper.updateData(
      url: "${EndPoints.categories}/$id",
      jwt: token,
      data: updateImage != null
          ? formData
          : imageRemoved
              ? {
                  "name": name,
                  "description": description,
                  "image": "",
                }
              : {
                  "name": name,
                  "description": description,
                },
    ).then((value) {
      getCategories();
      removeUpdateImage();
      emit(UpdateCategorySuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(UpdateCategoryError(errorMessage));
    });
  }

  void deleteCategory({
    required String id,
  }) {
    emit(DeleteCategoryLoading());
    DioHelper.deleteData(
      url: "${EndPoints.categories}/$id",
      jwt: token, data: {},
    ).then((value) {
      getCategories();
      emit(DeleteCategorySuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(DeleteCategoryError(errorMessage));
    });
  }
}
