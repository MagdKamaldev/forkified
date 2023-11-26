// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/sub_category.dart';
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
}
