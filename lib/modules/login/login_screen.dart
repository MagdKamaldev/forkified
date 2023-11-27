// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/home/home_layout.dart';
import 'package:forkified/modules/login/sign_up.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/login/login_cubit.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginLoading ||
            state is SignInWithGoogleLoadingState ||
            state is SignInWithFacebookLoadingState) {
          showDialog(
            context: context,
            builder: (context) => Lottie.asset(isDark!
                ? "assets/animations/forkified loading.json"
                : "assets/animations/forkified loading orange.json"),
          );
        } else if (state is LoginSuccess) {
          navigateAndFinish(context, const HomeLayout());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: isDark! ? prussianBlue : platinum,
            title: Text(
              "Get Started",
              style: theme.displayLarge!
                  .copyWith(color: isDark! ? platinum : prussianBlue),
            ),
            centerTitle: true,
            toolbarHeight: 90,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Text(
                    "Your Ingredients, Endless Recipes!",
                    style: theme.bodyMedium,
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  defaultFormField(
                      prefix: Icons.email,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      onSubmit: () {},
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "field required";
                        }
                      },
                      label: "Email",
                      context: context),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  defaultFormField(
                      prefix: Icons.password,
                      suffix: Icons.visibility_off,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      onSubmit: () {},
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "field required";
                        }
                      },
                      label: "password",
                      context: context),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  ConditionalBuilder(
                    builder: (context) => defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );
                          }
                        },
                        context: context,
                        text: "Login"),
                    condition: state is! LoginLoading,
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: isDark! ? nonPhotoBlueDark : flame,
                        width: 10,
                        height: 1,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "or",
                        style: theme.bodyLarge,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                        color: isDark! ? nonPhotoBlueDark : flame,
                        width: 10,
                        height: 1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Text(
                    "Sign in with",
                    style: theme.bodyLarge,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          LoginCubit.get(context)
                              .signInWithGoogle(context: context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFFEA4335),
                          ),
                          width: 60,
                          height: 60,
                          child: Image.asset(
                            "assets/images/google.png",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.15,
                      ),
                      GestureDetector(
                        onTap: () {
                          LoginCubit.get(context).signInWithFacebook(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF4267B2),
                          ),
                          width: 60,
                          height: 60,
                          child: Image.asset(
                            "assets/images/facebook.png",
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: theme.bodyMedium!.copyWith(
                            color: isDark! ? nonPhotoBlueDark : flame),
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, SignUpScreen());
                          },
                          child: Text(
                            "Sign Up",
                            style: theme.bodyLarge!.copyWith(
                                color: isDark! ? platinum : prussianBlue),
                          )),
                    ],
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
