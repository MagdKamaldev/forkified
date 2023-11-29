import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/user/user.dart';
import 'package:forkified/modules/admin/admin_screen.dart';
import 'package:forkified/modules/home/about_screen.dart';
import 'package:forkified/modules/home/categories/all_categories_screen.dart';
import 'package:forkified/modules/home/contact_screen.dart';
import 'package:forkified/modules/home/recipes/all_recipes_screen.dart';
import 'package:forkified/modules/home/settings/settings_screen.dart';
import 'package:forkified/modules/home/subcategories/all_subcategories_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/user/user_cubit.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    UserCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetUserDataLoading,
          fallback: (context) => Drawer(
            backgroundColor: isDark! ? prussianBlue : platinum,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  DrawerHeader(
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: isDark! ? cerulian : flame,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ListTile(
                    title: Text(
                      "Categories",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const AllCategoriesScreen());
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Sub Categories",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const AllSubCategoriesScreen());
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Recipes",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const AllRecipesScreen());
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Settings",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const SettingsScreen());
                    },
                  ),
                  ListTile(
                    title: Text(
                      "About",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const AboutScreen());
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Contact",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const ContactScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
          builder: (context) => Drawer(
            backgroundColor: isDark! ? prussianBlue : platinum,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  DrawerHeader(
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: isDark! ? cerulian : flame,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ListTile(
                    title: Text(
                      "Categories",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const AllCategoriesScreen());
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Sub Categories",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const AllSubCategoriesScreen());
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Recipes",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const AllRecipesScreen());
                    },
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
                  ListTile(
                    title: Text(
                      "Settings",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const SettingsScreen());
                    },
                  ),
                  ListTile(
                    title: Text(
                      "About",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const AboutScreen());
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Contact",
                      style: theme.displayMedium,
                    ),
                    onTap: () {
                      navigateTo(context, const ContactScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
