import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/categories.model.dart';
import 'package:forkified/models/sub_category.dart';
import 'package:forkified/modules/categories/subcategory_details_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/categories/categories_cubit.dart';
import 'package:forkified/shared/cubit/subcategory/subcategory_cubit.dart';
import 'package:forkified/shared/cubit/user/user_cubit.dart';
import 'package:lottie/lottie.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    UserCubit.get(context).getUserData();
    CategoriesCubit.get(context).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;

    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetUserDataLoading,
          fallback: (context) => Center(
              child: Lottie.asset(isDark!
                  ? "assets/animations/forkified loading.json"
                  : "assets/animations/forkified loading orange.json")),
          builder: (context) => Drawer(
            backgroundColor: isDark! ? prussianBlue : platinum,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  DrawerHeader(
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.8,
                    child: ListView.builder(
                      itemCount: CategoriesCubit.get(context).categories.length,
                      itemBuilder: (context, index) => categoryItem(
                          model: CategoriesCubit.get(context).categories[index],
                          size: size,
                          theme: theme),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget categoryItem({
    required CategoryModel model,
    required TextTheme theme,
    required Size size,
  }) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          model.name!,
          style: theme.displayMedium,
        ),
      ),
      onExpansionChanged: (value) {
        if (value) {}
      },
      children: [
        SizedBox(
          height: size.height * 0.01,
        ),
        SizedBox(
          height: 50,
          child: BlocConsumer<SubcategoryCubit, SubcategoryState>(
            listener: (context, state) {},
            builder: (context, state) {
              return ConditionalBuilder(
                condition: state is! GetCategorySubcategoriesLoading,
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                builder: (context) => model.subcategories!.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.subcategories!.length,
                        itemBuilder: (context, index) => subCategoryItem(
                            model: model.subcategories![index], theme: theme),
                      )
                    : const Center(child: Text("No Subcategories")),
              );
            },
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
      ],
    );
  }

  Widget subCategoryItem({
    required SubCategory model,
    required TextTheme theme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, SubCategoryDetails(id: model.id!));
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.name!,
              style: theme.displaySmall,
            ),
          ),
        ),
      ),
    );
  }
}
