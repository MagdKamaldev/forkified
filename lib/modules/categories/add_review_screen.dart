// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:forkified/main.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';
import 'package:lottie/lottie.dart';

class AddReview extends StatefulWidget {
  final String recipeId;
  AddReview({super.key, required this.recipeId});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  var controller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  int mainRating = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = RecipeCubit.get(context);
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;

    return BlocConsumer<RecipeCubit, RecipeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Add Review",
                style: theme.displayLarge,
              ),
              toolbarHeight: size.height * 0.08,
            ),
            body: ConditionalBuilder(
              condition: state is! AddReviewLoadingState,
              fallback: (context) => Center(
                  child: Lottie.asset(isDark!
                      ? "assets/animations/forkified loading.json"
                      : "assets/animations/forkified loading orange.json")),
              builder: (context) => SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDark! ? cerulian : flame,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              minLines: 1,
                              maxLines: null,
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: "Review ..",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Text("Rating :",
                            style: theme.displayLarge!.copyWith(
                                color: isDark! ? platinum : prussianBlue)),
                        SizedBox(height: size.height * 0.03),
                        Align(
                          alignment: Alignment.center,
                          child: RatingBar(
                            maxRating: 5,
                            minRating: 1,
                            itemSize: size.height * 0.07,
                            onRatingUpdate: (rating) {
                              setState(() {
                                mainRating = rating.toInt();
                              });
                            },
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              half: const Icon(
                                Icons.star_half,
                                color: Colors.amber,
                              ),
                              empty: const Icon(
                                Icons.star_border,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              width: size.width,
              height: size.height * 0.1,
              color: isDark! ? cerulian : flame,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate() && mainRating > 0) {
                    cubit.addReview(
                      recipeId: widget.recipeId,
                      review: controller.text,
                      rating: mainRating.toInt(),
                      context: context,
                    );
                  }
                },
                child: Text(
                  "Confrim",
                  style: theme.displayLarge!.copyWith(color: platinum),
                ),
              ),
            ));
      },
    );
  }
}
