import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/review/review.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';

class RecipeReviews extends StatelessWidget {
  final List<Review> reviews;
  const RecipeReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    var cubit = RecipeCubit.get(context);
    TextTheme theme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<RecipeCubit, RecipeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                " ${cubit.recipe!.name!} Reviews",
                style: theme.displayLarge,
                overflow: TextOverflow.ellipsis,
              ),
              toolbarHeight: size.height * 0.08,
            ),
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  itemBuilder: (context, index) => reviewBuilder(
                      review: reviews[index], size: size, theme: theme),
                      separatorBuilder: (context, index) => SizedBox(height: size.height*0.02,),
                  itemCount: reviews.length,
                )));
      },
    );
  }

  Widget reviewBuilder({
    Review? review,
    Size? size,
    TextTheme? theme,
  }) {
    List<Widget> stars = [];
    for (int i = 0; i < review!.rating!; i++) {
      stars.add(Icon(
        Icons.star,
        color: Colors.amber,
        size: size!.height * 0.03,
      ));
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: size!.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: isDark! ? cerulian : flame,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      review.user!.name!,
                      style: theme!.displayLarge,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    review.title!,
                    style: theme.displayMedium,
                  ),
                  Row(
                    children: stars,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
