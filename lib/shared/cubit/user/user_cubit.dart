// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/user/user.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/collections/collections_cubit.dart';
import 'package:forkified/shared/networks/local/cache_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
import '../../networks/remote/dio_helper.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  User? user;

  void getUserData() {
    emit(GetUserDataLoading());
    DioHelper.getData(
      url: EndPoints.users,
      jwt: token ?? CacheHelper.getData(key: "token"),
    ).then((value) {
      user = User.fromJson(value.data["document"]);
      emit(GetUserDataSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      debugPrint(errorMessage);
    });
  }

  void addRecipeToCollection({
    required String recipeId,
    required String collectionId,
    required BuildContext context,
  }) {
    emit(AddRecipeToCollectionLoading());
    DioHelper.updateData(
      url: "${EndPoints.collections}/$collectionId/${EndPoints.recipes}",
      data: {
        "recipe": recipeId,
      },
      jwt: token ?? CacheHelper.getData(key: "token"),
    ).then((value) {
      showCustomSnackBar(context, value.data["message"], Colors.green);
      Navigator.pop(context);
      Navigator.pop(context);
      CollectionsCubit.get(context).getCollection(id: collectionId);
      emit(AddRecipeToCollectionSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      debugPrint(errorMessage);
    });
  }

  void deleteRecipeFromCollection({
    required String recipeId,
    required String collectionId,
    required BuildContext context,
  }) {
    emit(DeleteRecipeFromCollectionLoading());
    DioHelper.deleteData(
        url: "${EndPoints.collections}/$collectionId/${EndPoints.recipes}",
        jwt: token ?? CacheHelper.getData(key: "token"),
        data: {
          "recipe": recipeId,
        }).then((value) {
      showCustomSnackBar(context, value.data["message"], Colors.red);
      Navigator.pop(context);
      CollectionsCubit.get(context).getCollection(id: collectionId);
      emit(DeleteRecipeFromCollectionSuccess());
    });
  }
}
