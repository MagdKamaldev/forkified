// ignore_for_file: use_key_in_widget_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/recipe_model.dart';
import 'package:forkified/modules/categories/recipe_details_screen.dart';
import 'package:forkified/modules/search/cubit/search_cubit.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = SearchCubit.get(context);
    TextTheme theme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: platinum,
              ),
              child: SearchBar(
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor: MaterialStateProperty.all<Color>(platinum),
                onSubmitted: (value) {
                  cubit.fetchRecipes(value);
                },
                onChanged: (value) {
                  cubit.fetchRecipes(value);
                },
                hintText: "Search for recipes",
              ),
            ),
            toolbarHeight: size.height * 0.08,
          ),
          body: ConditionalBuilder(
            condition: state is! SearchLoading,
            fallback: (context) => Center(
                child: Lottie.asset(isDark!
                    ? "assets/animations/forkified loading.json"
                    : "assets/animations/forkified loading orange.json")),
            builder: (context) => ConditionalBuilder(
              condition: cubit.recipes.isNotEmpty,
              fallback: (context) => Center(
                child: Text(
                  "No recipes found !",
                  style: theme.displayLarge,
                ),
              ),
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.14,
                        mainAxisSpacing: size.height * 0.02,
                        childAspectRatio: 1 / 1,
                        children: List.generate(
                          cubit.recipes.length,
                          (index) => buildRecipe(cubit.recipes[index], context,
                              index, size, theme),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildRecipe(
          RecipeModel model, context, index, Size size, TextTheme theme) =>
      GestureDetector(
        onTap: () {
          navigateTo(
              context,
              RecipeDetails(
                id: model.id!,
              ));
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
