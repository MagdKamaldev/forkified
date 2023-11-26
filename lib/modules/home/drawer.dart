import 'package:flutter/material.dart';
import 'package:forkified/modules/home/about_screen.dart';
import 'package:forkified/modules/home/all_categories_screen.dart';
import 'package:forkified/modules/home/contact_screen.dart';
import 'package:forkified/modules/home/all_recipes_screen.dart';
import 'package:forkified/modules/home/all_subcategories_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: prussianBlue,
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
              color: cerulian,
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
    );
  }
}
