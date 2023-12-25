import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/categories/update_review_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';
import 'package:forkified/shared/cubit/user/user_cubit.dart';
import 'package:lottie/lottie.dart';

class ReviewDetails extends StatefulWidget {
  final String id;
  const ReviewDetails({super.key, required this.id});

  @override
  State<ReviewDetails> createState() => _ReviewDetailsState();
}

class _ReviewDetailsState extends State<ReviewDetails> {
  List<Widget> stars = [];
  @override
  void initState() {
    UserCubit.get(context).getUserData();
    RecipeCubit.get(context).getReview(id: widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = RecipeCubit.get(context);
    TextTheme theme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! GetReviewLoadingState &&
                cubit.review != null &&
                state is! GetUserDataLoading &&
                state is! DeleteRecipeLoadingState &&
                UserCubit.get(context).user != null,
            fallback: (context) => Scaffold(
                  body: Center(
                      child: Lottie.asset(isDark!
                          ? "assets/animations/forkified loading.json"
                          : "assets/animations/forkified loading orange.json")),
                ),
            builder: (context) {
              for (int i = 0;
                  i < RecipeCubit.get(context).review!.rating!;
                  i++) {
                stars.add(Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: size.height * 0.035,
                ));
              }
              if (RecipeCubit.get(context).review!.rating! < 5) {
                for (int i = 0;
                    i < 5 - RecipeCubit.get(context).review!.rating!;
                    i++) {
                  stars.add(Icon(
                    Icons.star_border,
                    color: Colors.amber,
                    size: size.height * 0.035,
                  ));
                }
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    cubit.review!.recipe!.name!,
                    style: theme.displayLarge,
                  ),
                  actions: [
                    if (cubit.review!.user!.id ==
                        UserCubit.get(context).user!.id)
                      IconButton(
                          onPressed: () {
                            navigateTo(
                                context,
                                UpdateReviewScreen(
                                  review: cubit.review!,
                                ));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                            size: size.height * 0.035,
                          )),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    if (cubit.review!.user!.id ==
                        UserCubit.get(context).user!.id)
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Row(
                                      children: [
                                        Text("Delete ",
                                            style: theme.displayLarge!.copyWith(
                                                color: isDark!
                                                    ? cerulian
                                                    : flame)),
                                        SizedBox(
                                          width: size.width * 0.05,
                                        ),
                                        Icon(
                                          Icons.warning,
                                          color: isDark! ? cerulian : flame,
                                        )
                                      ],
                                    ),
                                    content: Text(
                                      "Are you sure you want to delete this Review ?",
                                      style: theme.bodyLarge!
                                          .copyWith(color: prussianBlue),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel",
                                              style: theme.displayMedium!
                                                  .copyWith(
                                                      color: isDark!
                                                          ? cerulian
                                                          : flame))),
                                      TextButton(
                                          onPressed: () {
                                            RecipeCubit.get(context)
                                                .deleteReview(
                                                    id: RecipeCubit.get(context)
                                                        .review!
                                                        .id!,
                                                    context: context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Delete",
                                              style: theme.displayMedium!
                                                  .copyWith(
                                                      color: isDark!
                                                          ? cerulian
                                                          : flame))),
                                    ],
                                  ));
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: size.height * 0.035,
                        ),
                      ),
                  ],
                  toolbarHeight: size.height * 0.08,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.5,
                              child: Text(
                                cubit.review!.user?.name ?? "Deleted User",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: theme.displayMedium!.copyWith(
                                  color: isDark! ? platinum : prussianBlue,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: stars,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isDark! ? cerulian : flame,
                                width: 2,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              cubit.review!.title!,
                              style: theme.displayMedium!.copyWith(
                                color: isDark!
                                    ? nonPhotoBlue
                                    : prussianBlue.shade100,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
