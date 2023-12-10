import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/user/collection.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/cubit/user/user_cubit.dart';
import 'package:lottie/lottie.dart';

class GetCollectionsToAddRecipe extends StatefulWidget {
  final String recipeId;
  const GetCollectionsToAddRecipe({super.key, required this.recipeId});

  @override
  State<GetCollectionsToAddRecipe> createState() =>
      _GetCollectionsToAddRecipeState();
}

class _GetCollectionsToAddRecipeState extends State<GetCollectionsToAddRecipe> {
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
            appBar: AppBar(
              title: Text(
                "Choose A collection",
                style: theme.displayLarge!,
              ),
              toolbarHeight: size.height * 0.08,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
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
                      const SizedBox(
                        height: 20,
                      ),
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

  Widget buildcollection({
    required TextTheme theme,
    required Size size,
    required Collection collection,
  }) =>
      GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                      "Are you sure you want to add the recipe to ${collection.name!}?",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            UserCubit.get(context).addRecipeToCollection(
                              collectionId: collection.id!,
                              recipeId: widget.recipeId,
                              context: context,
                            );
                          },
                          child: Text("Yes",
                              style: theme.displaySmall!.copyWith(
                                  color: isDark! ? cerulian : flame))),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No",
                              style: theme.displaySmall!.copyWith(
                                  color: isDark! ? cerulian : flame))),
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
                  height: size.height * 0.01,
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
