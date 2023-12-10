import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/sub_category.dart';
import 'package:forkified/modules/home/user/collections/add_recipe/from_sub/subcategory_recipes_for_adding.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/main/main_cubit.dart';
import 'package:lottie/lottie.dart';

class AllSubCategoriesScreenForAdding extends StatefulWidget {
  final String collectionId;
  const AllSubCategoriesScreenForAdding(
      {super.key, required this.collectionId});

  @override
  State<AllSubCategoriesScreenForAdding> createState() =>
      _AllSubCategoriesScreenForAddingState();
}

class _AllSubCategoriesScreenForAddingState
    extends State<AllSubCategoriesScreenForAdding> {
  @override
  void initState() {
    MainCubit.get(context).getAllSubcategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = MainCubit.get(context);

    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is GetAllSubcategoriesSuccess,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                "All Sub Categories",
                style: theme.displayLarge,
              ),
              toolbarHeight: size.height * 0.08,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return buildSubCategory(cubit.allSubCategories![index],
                            context, index, size, theme);
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.allSubCategories!.length,
                    ),
                    if (cubit.allSubCategories!.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.4,
                            ),
                            Text(
                              "No Sub Categories Found !",
                              style: theme.displayMedium,
                            ),
                          ],
                        ),
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

  Widget buildSubCategory(
          SubCategory model, context, index, Size size, TextTheme theme) =>
      GestureDetector(
        onTap: () {
          navigateTo(
              context,
              SubCategoryRecipesScreenForAdding(
                  id: model.id!, collectionId: widget.collectionId));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.displaySmall,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.035,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: isDark! ? cerulian : flame,
            ),
            SizedBox(
              height: size.height * 0.035,
            ),
          ],
        ),
      );
}
