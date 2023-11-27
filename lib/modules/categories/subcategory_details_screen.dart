import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/cubit/subcategory/subcategory_cubit.dart';
import 'package:lottie/lottie.dart';

class SubCategoryDetails extends StatefulWidget {
  final String id;
  const SubCategoryDetails({super.key, required this.id});

  @override
  State<SubCategoryDetails> createState() => _SubCategoryDetailsState();
}

class _SubCategoryDetailsState extends State<SubCategoryDetails> {
  @override
  void initState() {
    SubcategoryCubit.get(context).getSubCategory(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubcategoryCubit, SubcategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        TextTheme theme = Theme.of(context).textTheme;
        var cubit = SubcategoryCubit.get(context);
        return ConditionalBuilder(
          builder:(context) => Scaffold(
            appBar: AppBar(
              title: Text(
                SubcategoryCubit.get(context).subcategory!.name!,
                style: theme.displayLarge,
              ),
              toolbarHeight: size.height * 0.08,
            ),
            body: ConditionalBuilder(
              condition: state is!  GetSubCategoryLoading,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [             
                      Text(
                        cubit.subcategory!.name!,
                        style: theme.displayLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        cubit.subcategory!.description!,
                        style: theme.displaySmall,
                      ),
                      SizedBox(height: size.height*0.05,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isDark!? cerulian :flame,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(children: [
                            Text("Recipes", style: theme.displayMedium!.copyWith(color: isDark!? platinum : prussianBlue),),
                            const Spacer(),
                            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward,color: isDark!? platinum : flame,))
                          ],),
                        ),
                      )
                    ],
                  ),
                ),
              ),
               fallback: (context) => Center(child: LottieBuilder.asset("`assets/animations/forkified loading.json")), 
            ),
          ),
          condition: state is! GetSubCategoryLoading,
          fallback: (context) => Scaffold(
            body: Center(
                child:
                    Lottie.asset(isDark!? "assets/animations/forkified loading.json" :"assets/animations/forkified loading orange.json")),
          )
        );
      },
    );
  }
}
