import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/admin/admin_screen.dart';
import 'package:forkified/modules/home/categories/all_categories_screen.dart';
import 'package:forkified/modules/home/recipes/all_recipes_screen.dart';
import 'package:forkified/modules/home/subcategories/all_subcategories_screen.dart';
import 'package:forkified/modules/login/login_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/main/main_cubit.dart';
import 'package:forkified/shared/cubit/user/user_cubit.dart';
import 'package:forkified/shared/networks/local/cache_helper.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    UserCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = MainCubit.get(context);
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetUserDataLoading,
          fallback: (context) => Center(
              child: Lottie.asset(isDark!
                  ? "assets/animations/forkified loading.json"
                  : "assets/animations/forkified loading orange.json")),
          builder:(context)=> SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ListTile(
                        title: Text(
                          "All Categories",
                          style: theme.displayMedium,
                        ),
                        onTap: () {
                          navigateTo(context, const AllCategoriesScreen());
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: isDark! ? cerulian : flame,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ListTile(
                        title: Text(
                          "All Sub Categories",
                          style: theme.displayMedium,
                        ),
                        onTap: () {
                          navigateTo(context, const AllSubCategoriesScreen());
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: isDark! ? cerulian : flame,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ListTile(
                        title: Text(
                          "All Recipes",
                          style: theme.displayMedium,
                        ),
                        onTap: () {
                          navigateTo(context, const AllRecipesScreen());
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: isDark! ? cerulian : flame,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ListTile(
                        title: Text(
                          "Sign Out",
                          style: theme.displayMedium,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(
                                      "Are you sure you want to logout?",
                                      style: theme.displayLarge!.copyWith(
                                          color: isDark! ? cerulian : flame),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            navigateAndFinish(
                                                context, LoginScreen());
                                            CacheHelper.removeData(key: "token");
                                            token = "";
                                          },
                                          child: Text("Yes",
                                              style: theme.displaySmall!.copyWith(
                                                  color: isDark!
                                                      ? cerulian
                                                      : flame))),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("No",
                                              style: theme.displaySmall!.copyWith(
                                                  color: isDark!
                                                      ? cerulian
                                                      : flame))),
                                    ],
                                  ));
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: isDark! ? cerulian : flame,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Dark Mode",
                              style: theme.displayMedium,
                            ),
                            Switch(
                              value: isDark!,
                              onChanged: (bool value) {
                                cubit.changemode(value);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: isDark! ? cerulian : flame,
                      ),
                      if (UserCubit.get(context).user!.role == "admin")
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                      if (UserCubit.get(context).user!.role == "admin")
                        ListTile(
                          title: Text(
                            "Admin",
                            style: theme.displayMedium,
                          ),
                          onTap: () {
                            navigateTo(context, const AdminScreen());
                          },
                        ),
                      if (UserCubit.get(context).user!.role == "admin")
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                      if (UserCubit.get(context).user!.role == "admin")
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: isDark! ? cerulian : flame,
                        ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SizedBox(
                          width: size.width * 0.3,
                          height: size.height * 0.1,
                          child: Image.asset("assets/images/logo.png")),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "All Rights reserved  ${String.fromCharCode(169)} 2023 Forkified",
                        style: theme.bodyMedium,
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
