// ignore_for_file: deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  static SignupCubit get(context) => BlocProvider.of(context);

  void userSignUp({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    emit(SignupLoading());
    DioHelper.postData(
      url: EndPoints.signup,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phoneNumber': phoneNumber,
      },
    ).then((value) {
      emit(SignupSuccess());
    }).catchError((error) {
      String errorMessage = "An error occurred";
      if (error is DioError && error.response != null) {
        errorMessage = error.response!.data["message"];
      } else if (error is String) {
        errorMessage = error;
      }
      showCustomSnackBar(context, errorMessage, Colors.red);
      emit(SignupError(errorMessage));
    });
  }
}
