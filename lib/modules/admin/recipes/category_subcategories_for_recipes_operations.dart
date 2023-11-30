import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/sub_category.dart';
import 'package:forkified/modules/admin/recipes/subcategory_recipes_for_recipes_operations.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/subcategory/subcategory_cubit.dart';
import 'package:lottie/lottie.dart';

class SubCategoriesForRecipesOperations extends StatefulWidget {
  final String? id;
  const SubCategoriesForRecipesOperations({super.key, this.id});

  @override
  State<SubCategoriesForRecipesOperations> createState() =>
      _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategoriesForRecipesOperations> {
  @override
  void initState() {
    SubcategoryCubit.get(context).getCategorySubcategories(id: widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = SubcategoryCubit.get(context);
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    return BlocConsumer<SubcategoryCubit, SubcategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetCategorySubcategoriesLoading,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                "Choose a subCategory",
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
                        return buildSubCategory(cubit.subcategories![index],
                            context, index, size, theme);
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.subcategories!.length,
                    ),
                    if (cubit.subcategories!.isEmpty)
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
          navigateTo(context, SubCategoryRecipesForOperationsScreen(sub:model,));
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
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    color: isDark! ? cerulian : flame,
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
