import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/shared/cubit/app/app_cubit.dart';
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
    AppCubit.get(context).getCategory(id: widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;

    return BlocConsumer<AppCubit, AppState>(
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
                  children: [
                    Container(
                      height: size.height * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("$serverIp${cubit.category!.image!}"),
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
                        style: theme.bodyLarge!.copyWith(
                         fontWeight: FontWeight.bold
                        ),
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
