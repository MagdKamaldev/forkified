import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/recipe_model.dart';
import 'package:forkified/models/sub_category.dart';
import 'package:forkified/modules/admin/recipes/add_recipe_screen.dart';
import 'package:forkified/modules/admin/recipes/edit_delete_recipe_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';

class SubCategoryRecipesForOperationsScreen extends StatefulWidget {
  final SubCategory sub;
  const SubCategoryRecipesForOperationsScreen({super.key, required this.sub});

  @override
  State<SubCategoryRecipesForOperationsScreen> createState() =>
      _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState
    extends State<SubCategoryRecipesForOperationsScreen> {
  @override
  void initState() {
    RecipeCubit.get(context)
        .getSubCategoryRecipes(id: widget.sub.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = RecipeCubit.get(context);
    return BlocConsumer<RecipeCubit, RecipeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Choose a Recipe",
                style: theme.displayLarge,
              ),
              toolbarHeight: size.height * 0.08,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  ConditionalBuilder(
                    condition: state is! GetCategoryRecipesLoading,
                    fallback: (context) => GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: size.width * 0.12,
                      mainAxisSpacing: size.height * 0.05,
                      childAspectRatio: 1.6 / 1,
                      children: List.generate(
                        16,
                        (index) => Container(
                          height: size.height * 0.02,
                          decoration: BoxDecoration(
                            color: isDark! ? nonPhotoBlue : flame.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    builder: (context) => GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: size.width * 0.14,
                      mainAxisSpacing: size.height * 0.02,
                      childAspectRatio: 1 / 1,
                      children: List.generate(
                        cubit.categoryRecipes.length,
                        (index) => buildRecipe(cubit.categoryRecipes[index],
                            context, index, size, theme),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  if (cubit.categoryRecipes.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.4,
                          ),
                          Text(
                            "No Recipes Found !",
                            style: theme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                ]),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: isDark! ? cerulian : flame,
              onPressed: () {
                navigateTo(
                    context,
                    AddRecipe(
                      categoryId: widget.sub.category.toString(),
                      subCategoryId: widget.sub.id.toString(),
                    ));
              },
              child: Icon(Icons.add, color: platinum),
            ));
      },
    );
  }

  Widget buildRecipe(
          RecipeModel model, context, index, Size size, TextTheme theme) =>
      GestureDetector(
        onTap: () {
          navigateTo(
              context,
              EditDeleteRecipe(
                  categoryId: model.category.toString(),
                  subCategoryId: model.subcategory.toString(),
                  recipe: model));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark! ? cerulian : flame,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  "$serverIp${model.image.toString()}",
                  width: size.width * 0.35,
                  height: size.height * 0.1,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Container(
                        width: size.width * 0.35,
                        height: size.height * 0.1,
                        color: isDark! ? prussianBlue : platinum,
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: isDark! ? cerulian : flame,
                            size: size.height * 0.04,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              model.name.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.displaySmall,
            )
          ],
        ),
      );
}
