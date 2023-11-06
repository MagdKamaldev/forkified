import 'package:flutter/material.dart';
import 'package:forkified/modules/home/home_layout.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: prussianBlue,
        title: Text(
          "Sign Up",
          style: theme.displayLarge,
        ),
        centerTitle: true,
        toolbarHeight: 90,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Create an account to get started!",
                style: theme.bodyMedium,
              ),
              SizedBox(
                height: size.height * 0.05,
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
                height: size.height * 0.02,
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
                height: size.height * 0.02,
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
                label: "Password",
                context: context,
              ),
              SizedBox(
                height: size.height * 0.02,
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
                height: size.height * 0.04,
              ),
              defaultButton(
                function: () {
                  navigateTo(context, const HomeLayout());
                },
                context: context,
                text: "Sign Up",
              ),
              SizedBox(
                height: size.height * 0.03,
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
                height: size.height * 0.035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: theme.bodyMedium!.copyWith(color: nonPhotoBlue),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Log In",
                      style: theme.bodyLarge!.copyWith(color: platinum),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
