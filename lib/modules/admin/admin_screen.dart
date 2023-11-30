import 'package:flutter/material.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/admin/category/add_category_screen.dart';
import 'package:forkified/modules/admin/category/get_categorioes_for_update_screen.dart';
import 'package:forkified/modules/admin/recipes/get_categories_for_recipes_operations.dart';
import 'package:forkified/modules/admin/subCategory/add_sub_category.dart';
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
          "Admin",
          style: theme.displayLarge,
        ),
        toolbarHeight: size.height * 0.08,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      "Category",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              navigateTo(context, AddCategory());
                            },
                            child: Text(
                              "add",
                              style: theme.displaySmall,
                            )),
                        TextButton(
                            onPressed: () {
                              navigateTo(
                                  context, const AllCategoriesUpdateScreen());
                            },
                            child: Text("update /delete",
                                style: theme.displaySmall)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Column(
                  children: [
                    Text(
                      "Sub Category",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              navigateTo(context, AddSubCategory());
                            },
                            child: Text(
                              "add",
                              style: theme.displaySmall,
                            )),
                        TextButton(
                            onPressed: () {
                              navigateTo(context,
                                  const AllSubCategoriesForUpdateScreen());
                            },
                            child: Text("update / delete",
                                style: theme.displaySmall)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Column(
                  children: [
                    Text(
                      "Recipe",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              navigateTo(
                                  context, const AllCategoriesForRecipesScreen());
                            },
                            child: Text(
                              "add / update / delete",
                              style: theme.displaySmall,
                            )),
                     
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
