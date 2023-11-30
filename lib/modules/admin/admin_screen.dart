import 'package:flutter/material.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/admin/category/get_categorioes_for_update_screen.dart';
import 'package:forkified/modules/admin/recipes/get_categories_for_recipes_operations.dart';
import 'package:forkified/modules/admin/subCategory/get_all_subcategories_for_update.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Operations",
          style: theme.displayLarge,
        ),
        toolbarHeight: size.height * 0.08,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          width: size.width,
          child: Column(
            children: [
              Column(
                children: [
                  Icon(Icons.settings,
                      size: size.height * 0.1, color: isDark! ? cerulian : flame),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    "Add , Update and Delete operations",
                    style: theme.displayLarge!.copyWith(
                        color: isDark! ? cerulian : flame, fontSize: 18),
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, const AllCategoriesUpdateScreen());
                    },
                    child: Text(
                      "Category",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(
                          context, const AllSubCategoriesForUpdateScreen());
                    },
                    child: Text(
                      "Sub Category",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, const AllCategoriesForRecipesScreen());
                    },
                    child: Text(
                      "Recipe",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
