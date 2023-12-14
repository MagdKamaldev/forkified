import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/categories/add_review_screen.dart';
import 'package:forkified/modules/categories/get_collections_to_add_recipe.dart';
import 'package:forkified/modules/categories/recipe_reviews.dart';
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
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark! ? cerulian : flame,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.5),
                          child: Image.network(
                            "$serverIp${cubit.recipe!.image!}",
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  color: isDark! ? prussianBlue : platinum,
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
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: Text(
                            cubit.recipe!.name!,
                            overflow: TextOverflow.ellipsis,
                            style: theme.displayLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark! ? platinum : prussianBlue),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: size.height * 0.04,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          cubit.recipe!.ratingsAverage!.toStringAsFixed(1),
                          style: theme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.05),
                        ),
                      ],
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
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          "Reviews (${cubit.recipe!.reviews!.length}) ",
                          style: theme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.06,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark! ? cerulian : flame,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              navigateTo(
                                  context,
                                  RecipeReviews(
                                    reviews: cubit.recipe!.reviews!,
                                  ));
                            },
                            child: Text(
                              "View All",
                              style: theme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    defaultButton(
                        function: () {
                          navigateTo(
                              context,
                              AddReview(
                                recipeId: cubit.recipe!.id!,
                              ));
                        },
                        height: size.height * 0.07,
                        context: context,
                        text: "Add Review"),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      color: isDark! ? cerulian : flame,
                      width: double.infinity,
                      height: 1,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    if (cubit.recipe!.prepTime != null)
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
                    if (cubit.recipe!.prepTime != null)
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    if (cubit.recipe!.calories != null)
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
                    if (cubit.recipe!.calories != null)
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    if (cubit.recipe!.diet != null)
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
                                "Diet",
                                style: theme.displayMedium!.copyWith(
                                    color: isDark! ? platinum : prussianBlue),
                              ),
                              const Spacer(),
                              Text(
                                cubit.recipe!.diet!,
                                style: theme.displayMedium!.copyWith(
                                    color: isDark! ? platinum : prussianBlue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (cubit.recipe!.diet != null)
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    if (cubit.recipe!.vegetarian != null &&
                        cubit.recipe!.vegetarian == true)
                      SizedBox(
                        height: size.height * 0.07,
                        width: size.width * 0.9,
                        child: Row(
                          children: [
                            Text(
                              "Plant Based",
                              style: theme.displayMedium!.copyWith(
                                  color: isDark! ? platinum : prussianBlue),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: isDark! ? cerulian : flame,
                            ),
                            const Spacer(),
                            if (isDark!)
                              Image.asset("assets/images/plant-based.png"),
                            if (!isDark!)
                              Container(
                                width: size.width * 0.14,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(
                                    color: flame,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Image.asset(
                                    "assets/images/plant-based.png",
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    if (cubit.recipe!.vegetarian != null &&
                        cubit.recipe!.vegetarian == true)
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
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    defaultButton(
                        function: () {
                          navigateTo(
                              context,
                              GetCollectionsToAddRecipe(
                                recipeId: cubit.recipe!.id!,
                              ));
                        },
                        height: size.height * 0.07,
                        context: context,
                        text: "Add To collection"),
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
