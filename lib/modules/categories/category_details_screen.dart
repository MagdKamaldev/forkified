import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      height: size.height * 0.02,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: cerulian,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          "sub categories",
                          style: theme.displayLarge!.copyWith(color: platinum),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              navigateTo(
                                  context,
                                  SubCategories(
                                    id: cubit.category!.id,
                                  ));
                            },
                            icon: Icon(
                              Icons.arrow_forward_sharp,
                              color: platinum,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
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
