import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/models/recipe_model.dart';
import 'package:forkified/modules/categories/recipe_details_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';

class CategoryRecipesScreen extends StatefulWidget {
  final String id;
  const CategoryRecipesScreen({super.key, required this.id});

  @override
  State<CategoryRecipesScreen> createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  @override
  void initState() {
    RecipeCubit.get(context).getCategoryRecipes(id: widget.id);
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
              "Recipes",
              style: theme.displayLarge,
            ),
            toolbarHeight: size.height * 0.08,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                ConditionalBuilder(
                  condition: state is GetCategoryRecipesSuccess,
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
                          color: nonPhotoBlue,
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
                      (index) => buildCategory(cubit.categoryRecipes[index],
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
        );
      },
    );
  }

  Widget buildCategory(
          RecipeModel model, context, index, Size size, TextTheme theme) =>
      GestureDetector(
        onTap: () {
          navigateTo(context, RecipeDetails(id: model.id.toString()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: cerulian,
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
                        color: prussianBlue,
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: cerulian,
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
