// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoading());
    DioHelper.postData(
      url: EndPoints.login,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      emit(LoginSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      showCustomSnackBar(context, errorMessage, Colors.red);
      emit(LoginError(errorMessage));
    });
  }
}
