import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/review/review.dart';
import 'package:forkified/modules/categories/review_details_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';

class RecipeReviews extends StatefulWidget {
  final List<Review> reviews;
  const RecipeReviews({super.key, required this.reviews});

  @override
  State<RecipeReviews> createState() => _RecipeReviewsState();
}

class _RecipeReviewsState extends State<RecipeReviews> {
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
                      context: context,
                      review: widget.reviews[index],
                      size: size,
                      theme: theme),
                  separatorBuilder: (context, index) => SizedBox(
                    height: size.height * 0.02,
                  ),
                  itemCount: widget.reviews.length,
                )));
      },
    );
  }

  Widget reviewBuilder({
    Review? review,
    Size? size,
    TextTheme? theme,
    BuildContext? context,
  }) {
    List<Widget> stars = [];
    for (int i = 0; i < review!.rating!; i++) {
      stars.add(Icon(
        Icons.star,
        color: Colors.amber,
        size: size!.height * 0.03,
      ));
    }
    if (review.rating! < 5) {
      for (int i = 0; i < 5 - review.rating!; i++) {
        stars.add(Icon(
          Icons.star_border,
          color: Colors.amber,
          size: size!.height * 0.03,
        ));
      }
    }
    return GestureDetector(
      onTap: () {
        navigateTo(context, ReviewDetails(id: review.id!));
      },
      child: ClipRRect(
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
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          review.user?.name! ?? "Deleted Account",
                          style: theme!.displayLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: stars,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: size.width * 0.9,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          review.title!,
                          style: theme.displayMedium!.copyWith(
                            color: prussianBlue,
                          ),
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
