// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/home/home_layout.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/signup/signup_cubit.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = SignupCubit.get(context);
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading ||
            state is SignUpWithGoogleLoadingState ||
            state is SignUpWithFacebookLoadingState) {
          showDialog(
            context: context,
            builder: (context) => Lottie.asset(isDark!
                ? "assets/animations/forkified loading.json"
                : "assets/animations/forkified loading orange.json"),
          );
        } else if (state is SignupSuccess) {
          navigateAndFinish(context, const HomeLayout());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: isDark! ? prussianBlue : platinum,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: isDark! ? platinum : prussianBlue,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              "Sign Up",
              style: theme.displayLarge!
                  .copyWith(color: isDark! ? platinum : prussianBlue),
            ),
            centerTitle: true,
            toolbarHeight: 80,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Create an account to get started!",
                      style: theme.bodyMedium,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    defaultFormField(
                      prefix: Icons.person,
                      controller: nameController,
                      type: TextInputType.name,
                      onSubmit: () {},
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "field required";
                        }
                      },
                      label: "Name",
                      context: context,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
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
                      context: context,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    defaultFormField(
                      prefix: Icons.phone,
                      controller: phoneNumberController,
                      type: TextInputType.phone,
                      onSubmit: () {},
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "field required";
                        }
                      },
                      label: "Phone Number",
                      context: context,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    defaultFormField(
                      prefix: Icons.password,
                      suffix: cubit.passsuffix,
                      isPassword: cubit.passisPassword,
                      suffixPressed: () {
                        cubit.changePassword();
                      },
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      onSubmit: () {},
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "field required";
                        }
                      },
                      label: "Password",
                      context: context,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    defaultFormField(
                      prefix: Icons.lock,
                      suffix: cubit.confirmsuffix,
                      isPassword: cubit.confirmisPassword,
                      suffixPressed: () {
                        cubit.changeconfirmPassword();
                      },
                      controller: confirmPasswordController,
                      type: TextInputType.visiblePassword,
                      onSubmit: () {},
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "field required";
                        } else if (value != passwordController.text) {
                          return "passwords must match";
                        }
                      },
                      label: "Confirm Password",
                      context: context,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ConditionalBuilder(
                        condition: state is! SignupLoading,
                        builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SignupCubit.get(context).userSignUp(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phoneNumber: phoneNumberController.text,
                                    context: context,
                                  );
                                }
                              },
                              context: context,
                              text: "Sign Up",
                            ),
                        fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            )),
                    SizedBox(
                      height: size.height * 0.02,
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
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Sign up with",
                      style: theme.bodyLarge,
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => SignupCubit.get(context)
                              .signInWithGoogle(context: context),
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
                            SignupCubit.get(context)
                                .signUpWithFacebook(context);
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
                      height: size.height * 0.035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: theme.bodyMedium!.copyWith(
                              color: isDark! ? nonPhotoBlueDark : flame),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Log In",
                            style: theme.bodyLarge!.copyWith(
                                color: isDark! ? platinum : prussianBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
