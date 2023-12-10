import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/recipe_model.dart';
import 'package:forkified/modules/home/user/collections/add_recipe/from_category/add_recipe_from_category.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/collections/collections_cubit.dart';
import 'package:lottie/lottie.dart';
import '../../../../shared/colors.dart';
import '../../../../shared/networks/remote/dio_helper.dart';

class CollectionDetails extends StatefulWidget {
  final String id;
  const CollectionDetails({super.key, required this.id});

  @override
  State<CollectionDetails> createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<CollectionDetails> {
  @override
  void initState() {
    CollectionsCubit.get(context).getCollection(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollectionsCubit, CollectionsState>(
      listener: (context, state) {},
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        TextTheme theme = Theme.of(context).textTheme;
        return ConditionalBuilder(
          condition: state is! GetCollectionLoading,
          fallback: (context) => Scaffold(
            body: Center(
                child: Lottie.asset(isDark!
                    ? "assets/animations/forkified loading.json"
                    : "assets/animations/forkified loading orange.json")),
          ),
          builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(
                    CollectionsCubit.get(context).collection!.name!.toString(),
                    style: theme.displayLarge!),
                toolbarHeight: size.height * 0.08,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recipes",
                        style: theme.displayLarge!.copyWith(
                          color: isDark! ? cerulian : prussianBlue,
                        ),
                      ),
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
                          CollectionsCubit.get(context)
                              .collection!
                              .recipes!
                              .length,
                          (index) => buildRecipe(
                              CollectionsCubit.get(context)
                                  .collection!
                                  .recipes![index]!,
                              context,
                              index,
                              size,
                              theme),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              "Choose a recipe from : ",
                              style: theme.displayLarge!
                                  .copyWith(color: isDark! ? cerulian : flame),
                            ),
                            actionsOverflowAlignment:
                                OverflowBarAlignment.center,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    navigateTo(
                                        context,
                                        AllCategoriesScreenForAdding(
                                          collectionId:
                                              CollectionsCubit.get(context)
                                                  .collection!
                                                  .id!,
                                        ));
                                  },
                                  child: Text("Category",
                                      style: theme.displaySmall!.copyWith(
                                          color: isDark! ? cerulian : flame))),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Subcategory",
                                      style: theme.displaySmall!.copyWith(
                                          color: isDark! ? cerulian : flame))),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("All Recipes",
                                      style: theme.displaySmall!.copyWith(
                                          color: isDark! ? cerulian : flame))),
                            ],
                          ));
                },
                child: Icon(
                  Icons.add,
                  color: platinum,
                ),
              )),
        );
      },
    );
  }

  Widget buildRecipe(
          RecipeModel model, context, index, Size size, TextTheme theme) =>
      GestureDetector(
        onTap: () {
          // navigateTo(
          //     context,
          //     CategoryDetails(
          //       id: model.id,
          //     ));
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

//  return buildRecipe(
//                               CollectionsCubit.get(context)
//                                   .collection!
//                                   .recipes![index]!,
//                               context,
//                               index,
//                               size,
//                               theme);