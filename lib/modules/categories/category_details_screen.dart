import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/modules/categories/recipes_screen.dart';
import 'package:forkified/modules/categories/subcategories_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/categories/categories_cubit.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:lottie/lottie.dart';

class CategoryDetails extends StatefulWidget {
  final String? id;
  const CategoryDetails({super.key, this.id});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    CategoriesCubit.get(context).getCategory(id: widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = CategoriesCubit.get(context);
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;

    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is GetCategorySuccess,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.category!.name!,
                style: theme.displayLarge,
              ),
              toolbarHeight: size.height * 0.08,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: cerulian,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          "$serverIp${cubit.category!.image!}",
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Container(
                                color: prussianBlue,
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    color: cerulian,
                                    size: size.height * 0.1,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        cubit.category!.description!,
                        style: theme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateTo(
                            context,
                            SubCategories(
                              id: cubit.category!.id,
                            ));
                      },
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.42,
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: cerulian,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Sub Categories",
                                style: theme.displaySmall!
                                    .copyWith(color: platinum),
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              navigateTo(
                                  context,
                                  CategoryRecipesScreen(
                                    id: cubit.category!.id!,
                                  ));
                            },
                            child: Container(
                              width: size.width * 0.42,
                              height: size.height * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: cerulian,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Recipes",
                                  style: theme.displaySmall!
                                      .copyWith(color: platinum),
                                ),
                              ),
                            ),
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
                child:
                    Lottie.asset("assets/animations/forkified loading.json")),
          ),
        );
      },
    );
  }
}
