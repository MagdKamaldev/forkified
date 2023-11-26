import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/models/sub_category.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/cubit/subcategory/subcategory_cubit.dart';
import 'package:lottie/lottie.dart';

class SubCategories extends StatefulWidget {
  final String? id;
  const SubCategories({super.key, this.id});

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
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
          condition: state is GetCategorySubcategoriesSuccess,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                "Sub Categories",
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
                   ListView.builder(itemBuilder: (context, index) {
                      return buildCategory(
                          cubit.subcategories![index], context, index, size, theme);
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.subcategories!.length,),
                    if(cubit.subcategories!.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: size.height*0.4,),
                            Text("No Sub Categories Found !",style: theme.displayMedium,),
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
   Widget buildCategory(
          SubCategory model, context, index, Size size, TextTheme theme) =>
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
                    Icons.arrow_forward_ios,
                    color: cerulian,
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
            color: cerulian,
          ),
          SizedBox(
            height: size.height * 0.035,
          ),
          ],
        ),
      );

}
