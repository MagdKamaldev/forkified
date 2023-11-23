// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  static SignupCubit get(context) => BlocProvider.of(context);

  void userSignUp({
    required String email,
    required String password,
    required String name,
    String ? phoneNumber,
    required BuildContext context,
  }) async {
    emit(SignupLoading());
    DioHelper.postData(
      url: EndPoints.signup,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phoneNumber': phoneNumber??"",
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

    final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void signInWithGoogle({required BuildContext context}) {
    emit(SignUpWithGoogleLoadingState());
    _googleSignIn.signIn().then((GoogleSignInAccount? googleSignInAccount) {
      if (googleSignInAccount != null) {
        googleSignInAccount.authentication
            .then((GoogleSignInAuthentication auth) {
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: auth.accessToken,
            idToken: auth.idToken,
          );

          _auth
              .signInWithCredential(credential)
              .then((UserCredential userCredential) {
            userSignUp(
              name: userCredential.user!.displayName.toString(),
                email: userCredential.user!.email.toString(),
                password: "Google123",
                context: context);
          
            // Successfully signed in with Google
            emit(SignUpWithGoogleSuccesState());
          }).catchError((e) {
            // Handle sign-in errors
            emit(SignUpWithGoogleErrorState());
          });
        }).catchError((e) {
          // Handle authentication errors
          emit(SignUpWithGoogleErrorState());
        });
      }
    }).catchError((e) {
      // Handle sign-in errors
      emit(SignUpWithGoogleErrorState());
    });
  }
}
