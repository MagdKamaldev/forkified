import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/categories.model.dart';
import 'package:forkified/modules/admin/category/add_category_screen.dart';
import 'package:forkified/modules/admin/category/update_category_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/cubit/main/main_cubit.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import '../../../shared/components.dart';

class AllCategoriesUpdateScreen extends StatefulWidget {
  const AllCategoriesUpdateScreen({super.key});

  @override
  State<AllCategoriesUpdateScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesUpdateScreen> {
  @override
  void initState() {
    MainCubit.get(context).getAllCategories();
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
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Choose a Category",
                style: theme.displayLarge,
              ),
              toolbarHeight: size.height * 0.08,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  ConditionalBuilder(
                    condition: cubit.allCategories!.isNotEmpty,
                    fallback: (context) => GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: size.width * 0.12,
                      mainAxisSpacing: size.height * 0.05,
                      childAspectRatio: 1.6 / 1,
                      children: List.generate(
                        16,
                        (index) => Container(
                          height: size.height * 0.02,
                          decoration: BoxDecoration(
                            color: isDark! ? nonPhotoBlue : flame.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    builder: (context) => GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: size.width * 0.14,
                      mainAxisSpacing: size.height * 0.02,
                      childAspectRatio: 1 / 1,
                      children: List.generate(
                        cubit.allCategories!.length,
                        (index) => buildCategory(cubit.allCategories![index],
                            context, index, size, theme),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  )
                ]),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateTo(context, AddCategory());
              },
              backgroundColor: isDark! ? cerulian : flame,
              child: Icon(
                Icons.add,
                color: platinum,
              ),
            ));
      },
    );
  }

  Widget buildCategory(
          CategoryModel model, context, index, Size size, TextTheme theme) =>
      GestureDetector(
        onTap: () {
          navigateTo(
              context,
              UpdateCategoryScreen(
                category: model,
              ));
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
