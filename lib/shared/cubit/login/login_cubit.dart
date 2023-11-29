// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:forkified/main.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/networks/local/cache_helper.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/networks/remote/end_points.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      token = value.data["token"];
      CacheHelper.saveData(key: "token", value: value.data["token"]);
      CacheHelper.saveData(key: "start", value: "home");
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void signInWithGoogle({required BuildContext context}) {
    emit(SignInWithGoogleLoadingState());
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
            userLogin(
                email: userCredential.user!.email.toString(),
                password: "Google123",
                context: context);
            if (state is LoginError) {
              showCustomSnackBar(
                  context, "Please sign up with google first", Colors.red);
            }
            // Successfully signed in with Google
            emit(SignInWithGoogleSuccesState());
          }).catchError((e) {
            // Handle sign-in errors
            emit(SignInWithGoogleErrorState());
          });
        }).catchError((e) {
          // Handle authentication errors
          emit(SignInWithGoogleErrorState());
        });
      }
    }).catchError((e) {
      // Handle sign-in errors
      emit(SignInWithGoogleErrorState());
    });
  }

  void signInWithFacebook(context) {
    emit(SignInWithFacebookLoadingState());
    FacebookAuth.instance.login().then((LoginResult loginResult) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential)
          .then((UserCredential userCredential) {
        User user = userCredential.user!;
        userLogin(
            email: user.email!, password: "Facebook123", context: context);
      }).catchError((error) {
        showCustomSnackBar(context, error.toString(), Colors.red);
        emit(SignInWithFacebookErrorState());
      });
    }).catchError((error) {
      showCustomSnackBar(context, error.toString(), Colors.red);
      emit(SignInWithFacebookErrorState());
    });
  }
}
