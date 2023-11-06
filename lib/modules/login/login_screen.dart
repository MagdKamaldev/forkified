import 'package:flutter/material.dart';
import 'package:forkified/modules/home/home_layout.dart';
import 'package:forkified/modules/login/sign_up.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: prussianBlue,
        title: Text(
          "Get Started",
          style: theme.displayLarge,
        ),
        centerTitle: true,
        toolbarHeight: 90,
      ),
      body: SingleChildScrollView(
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
            defaultButton(
                function: () {
                  navigateTo(context, const HomeLayout());
                },
                context: context,
                text: "Login"),
            SizedBox(
              height: size.height * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: nonPhotoBlueDark,
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
                  color: nonPhotoBlueDark,
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
                Container(
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
                SizedBox(
                  width: size.width * 0.15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF4267B2),
                  ),
                  width: 60,
                  height: 60,
                  child: Image.asset(
                    "assets/images/facebook.png",
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
                  style: theme.bodyMedium!.copyWith(color: nonPhotoBlue),
                ),
                TextButton(
                    onPressed: () {
                      navigateTo(context, const SignUpScreen());
                    },
                    child: Text(
                      "Sign Up",
                      style: theme.bodyLarge!.copyWith(color: platinum),
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
