import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';
import 'package:lottie/lottie.dart';

import '../../shared/networks/remote/dio_helper.dart';

class RecipeDetails extends StatefulWidget {
  final String id;
  const RecipeDetails({super.key, required this.id});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  void initState() {
    RecipeCubit.get(context).getRecipe(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        TextTheme theme = Theme.of(context).textTheme;
        var cubit = RecipeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.recipe != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.recipe!.name!,
                style: theme.displayLarge,
              ),
              toolbarHeight: size.height * 0.08,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (cubit.recipe!.image != null)
                      Container(
                        height: size.height * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isDark! ? cerulian : flame,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            "$serverIp${cubit.recipe!.image!}",
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Container(
                                  color: prussianBlue,
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: isDark! ? cerulian : flame,
                                      size: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    if (cubit.recipe!.image == null)
                      Container(
                        height: size.height * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isDark! ? cerulian : flame,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.image,
                            color: isDark! ? cerulian : flame,
                            size: size.height * 0.1,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        cubit.recipe!.description!,
                        style: theme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDark! ? cerulian : flame,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Text(
                              "Preparation time",
                              style: theme.displayMedium!.copyWith(
                                  color: isDark! ? platinum : prussianBlue),
                            ),
                            const Spacer(),
                            Text(
                              cubit.recipe!.prepTime.toString(),
                              style: theme.displayMedium!.copyWith(
                                  color: isDark! ? platinum : prussianBlue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDark! ? cerulian : flame,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Text(
                              "Calories",
                              style: theme.displayMedium!.copyWith(
                                  color: isDark! ? platinum : prussianBlue),
                            ),
                            const Spacer(),
                            Text(
                              cubit.recipe!.calories.toString(),
                              style: theme.displayMedium!.copyWith(
                                  color: isDark! ? platinum : prussianBlue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    defaultItemBuilder(
                      context: context,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 180,
                              child: ListView.builder(
                                itemBuilder: (ctx, index) => SizedBox(
                                  height: size.height * 0.06,
                                  child: Card(
                                    color: isDark! ? cerulian : flame,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              cubit.recipe!.ingredients![index],
                                              style: theme.displaySmall!
                                                  .copyWith(color: platinum),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                itemCount: cubit.recipe!.ingredients!.length,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                          ],
                        ),
                      ),
                      description: "Ingredients",
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Scaffold(
            body: Center(
                child: Lottie.asset(isDark!
                    ? "assets/animations/forkified loading.json"
                    : "assets/animations/forkified loading orange.json")),
          ),
        );
      },
    );
  }
}
