// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/user/collection.dart';
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
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      emit(GetCollectionError(errorMessage));
    });
  } 
}
