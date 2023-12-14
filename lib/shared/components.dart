import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forkified/main.dart';
import 'package:forkified/shared/colors.dart';

void navigateTo(context, widget) => Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, CupertinoPageRoute(builder: (context) => widget), (route) {
      return false;
    });

Widget defaultItemBuilder(
        {required Widget child,
        required String description,
        required BuildContext context}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(description,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: isDark! ? cerulian : prussianBlue,
                )),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark! ? nonPhotoBlue : platinum,
            border: Border.all(color: isDark! ? cerulian : flame, width: 5),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 200,
          width: double.infinity,
          child: child,
        ),
      ],
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function onSubmit,
  required Function validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        validator: (value) {
          return validate(value);
        },
        controller: controller,
        keyboardType: type,
        enabled: isClickable,
        obscureText: isPassword,
        onFieldSubmitted: (s) {
          onSubmit();
        },
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: isDark! ? platinum : blackOlive, // Set the text color here
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 16, color: isDark! ? nonPhotoBlueDark : flame),
          prefixIcon: Icon(
            prefix,
            color: isDark! ? nonPhotoBlueDark : flame,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                    color: isDark! ? nonPhotoBlueDark : flame,
                  ),
                  onPressed: () {
                    suffixPressed!();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}

void showCustomSnackBar(
    BuildContext context, String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
    ),
  );
}

Widget defaultButton({
  double height = 52,
  double width = double.infinity,
  bool isUpperCase = false,
  double radius = 20.0,
  required VoidCallback function,
  required BuildContext context,
  required String text,
}) =>
    Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: isDark! ? cerulian : flame,
        ),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: platinum, fontSize: 16),
          ),
        ));
