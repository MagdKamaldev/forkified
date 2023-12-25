import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/models/review/review.dart';
import 'package:forkified/models/user/collection.dart';
import 'package:forkified/modules/categories/review_details_screen.dart';
import 'package:forkified/modules/home/user/collections/collcetion_details.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/collections/collections_cubit.dart';
import 'package:lottie/lottie.dart';
import '../../../main.dart';
import '../../../shared/colors.dart';
import '../../../shared/cubit/user/user_cubit.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    UserCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetUserDataLoading,
          builder: (context) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Center(
                        child: Text(
                          cubit.user!.name!.toUpperCase(),
                          style: theme.displayLarge!.copyWith(
                              color: isDark! ? platinum : prussianBlue),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isDark! ? cerulian : flame,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Email ",
                                style: theme.displaySmall!.copyWith(
                                    color: isDark! ? platinum : prussianBlue),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              Text(
                                cubit.user!.email!,
                                style: theme.displaySmall!.copyWith(
                                    color: isDark! ? platinum : prussianBlue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Container(
                        color: isDark! ? cerulian : flame,
                        width: double.infinity,
                        height: 1,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text("Your Collections :",
                          style: theme.displayLarge!
                              .copyWith(color: isDark! ? cerulian : flame)),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      if (cubit.user!.collections!.isEmpty)
                        SizedBox(
                          height: size.height * 0.2,
                        ),
                      if (cubit.user!.collections!.isEmpty)
                        Center(
                          child: Text("You don't have any collections yet !",
                              style: theme.displaySmall!.copyWith(
                                  color: isDark! ? platinum : prussianBlue)),
                        ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.14,
                        mainAxisSpacing: size.height * 0.02,
                        childAspectRatio: 1 / 1,
                        children: List.generate(
                          cubit.user!.collections!.length,
                          (index) => buildcollection(
                            theme: theme,
                            size: size,
                            collection: cubit.user!.collections![index]!,
                          ),
                        ),
                      ),
                      if (cubit.user!.collections!.isNotEmpty)
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                      if (cubit.user!.collections!.isNotEmpty)
                        Center(
                          child: Text("Long press to delete collection !",
                              style: theme.displaySmall!.copyWith(
                                  color: isDark!
                                      ? prussianBlue.shade300
                                      : Colors.grey)),
                        ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        color: isDark! ? cerulian : flame,
                        width: double.infinity,
                        height: 1,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text("Your Reviews :",
                          style: theme.displayLarge!
                              .copyWith(color: isDark! ? cerulian : flame)),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      SizedBox(
                        height:
                            size.height * 0.25 * cubit.user!.reviews!.length,
                        child: ListView.separated(
                          itemBuilder: (context, index) => reviewBuilder(
                              context: context,
                              review: cubit.user!.reviews![index],
                              size: size,
                              theme: theme),
                          separatorBuilder: (context, index) => SizedBox(
                            height: size.height * 0.02,
                          ),
                          itemCount: cubit.user!.reviews!.length,
                        ),
                      )
                    ],
                  ),
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
              if (review.recipe != null)
                Container(
                  color: isDark! ? cerulian : flame,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.5,
                          child: Text(
                            review.recipe!.name ?? "Deleted Recipe",
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
                          style: theme!.displayMedium!.copyWith(
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

  Widget buildcollection({
    required TextTheme theme,
    required Size size,
    required Collection collection,
  }) =>
      GestureDetector(
        onTap: () {
          navigateTo(
            context,
            CollectionDetails(
              id: collection.id!,
            ),
          );
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                      "Are you sure you want to remove this Collection ?",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            CollectionsCubit.get(context).deleteCollection(
                                collectionId: collection.id!, context: context);
                          },
                          child: Text(
                            "Yes",
                            style: theme.displayMedium,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No", style: theme.displayMedium)),
                    ],
                  ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDark! ? cerulian : flame,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  collection.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.displaySmall!
                      .copyWith(color: isDark! ? platinum : prussianBlue),
                ),
                SizedBox(
                  height: size.height * 0.008,
                ),
                Image.asset(
                  "assets/images/paper.png",
                  width: size.width * 0.14,
                  height: size.height * 0.065,
                )
              ],
            ),
          ),
        ),
      );
}
