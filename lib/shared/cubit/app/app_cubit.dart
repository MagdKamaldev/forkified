// ignore_for_file: deprecated_member_use
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/models/categories.model.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
import '../../../main.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

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

  List<dynamic> categories = [];

  void getCategories() {
    emit(GetCategoriesLoading());
    DioHelper.getData(
      url: EndPoints.categories,
      jwt: token,
    ).then((value) {  
      categories = value.data["categories"]!.map((e) => CategoryModel.fromJson(e)).toList();
      categories[0].description.toString();
      emit(GetCategoriesSuccess());
    });
    // .catchError((error) {
    //   String errorMessage = "An error occurred";
    //   if (error is DioError && error.response != null) {
    //     errorMessage = error.response!.data["message"];
    //   } else if (error is String) {
    //     errorMessage = error;
    //   }
    //   print(errorMessage);
    //   emit(GetCategoriesError(errorMessage));
    // });
  }
}
