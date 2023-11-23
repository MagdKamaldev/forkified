// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/shared/components.dart';
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

  // Future<User?> signInWithGoogle({required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;

  //   if (kIsWeb) {
  //     GoogleAuthProvider authProvider = GoogleAuthProvider();
  //     try {
  //       final UserCredential userCredential =
  //           await auth.signInWithPopup(authProvider);

  //       user = userCredential.user;
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();

  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();

  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );

  //       try {
  //         final UserCredential userCredential =
  //             await auth.signInWithCredential(credential);

  //         user = userCredential.user;
  //         emit(SignInWithGoogleSuccesState());
  //       } on FirebaseAuthException catch (e) {
  //         if (e.code == 'account-exists-with-different-credential') {
  //           print(e.code);
  //         } else if (e.code == 'invalid-credential') {
  //           // ...
  //            print(e.code);
  //         }
  //       } catch (e) {
  //         // ...
  //          print(e.toString());
  //       }
  //     }
  //   }

  //   return user;
  // }
}
