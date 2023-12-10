// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/user/collection.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/user/user_cubit.dart';
import 'package:forkified/shared/networks/local/cache_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
import '../../networks/remote/dio_helper.dart';
part 'collections_state.dart';

class CollectionsCubit extends Cubit<CollectionsState> {
  CollectionsCubit() : super(CollectionsInitial());
  static CollectionsCubit get(context) => BlocProvider.of(context);

  Collection? collection;

  void getCollection({
    required String id,
  }) {
    emit(GetCollectionLoading());
    DioHelper.getData(
      url: "${EndPoints.collections}/$id",
      jwt: CacheHelper.getData(key: "token"),
    ).then((value) {
      collection = Collection.fromJson(value.data["collection"]);
      emit(GetCollectionSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.statusMessage!;
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetCollectionError(errorMessage));
    });
  }

  void addCollection({
    required String name,
    required BuildContext context,
    required TextTheme theme,
    required Size size,
  }) {
    emit(AddCollectionLoading());
    DioHelper.postData(
      url: EndPoints.collections,
      jwt: CacheHelper.getData(key: "token"),
      data: {
        "name": name,
      },
    ).then((value) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text(
                  "Success !",
                  style: theme.displayLarge!
                      .copyWith(color: isDark! ? cerulian : flame),
                ),
                content: SizedBox(
                  height: size.height*0.117,
                  child: Column(
                    children: [
                      SizedBox(
                         width: size.width * 0.14,
                    height: size.height * 0.065,
                        child: Image.asset("assets/images/news.png")),
                        SizedBox(height: size.height*0.02,),
                      Text(
                        value.data["message"],
                        style: theme.displaySmall!
                            .copyWith(color: isDark! ? platinum : prussianBlue),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              )));
      emit(AddCollectionSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.statusMessage!;
      } else if (error is String) {
        errorMessage = error;
      }
      showCustomSnackBar(context, errorMessage, Colors.red);
      emit(AddCollectionError(errorMessage));
    });
  }

  void deleteCollection({
    required String collectionId,
    required BuildContext context,
  }){
    emit(DeleteCollectionLoading());
    DioHelper.deleteData(
      data:{},
      url: "${EndPoints.collections}/$collectionId",
      jwt: CacheHelper.getData(key: "token"),
    ).then((value) {
      Navigator.pop(context);
      UserCubit.get(context).getUserData();
      emit(DeleteCollectionSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.statusMessage!;
      } else if (error is String) {
        errorMessage = error;
      }
      emit(DeleteCollectionError(errorMessage));
    });
  }
}
