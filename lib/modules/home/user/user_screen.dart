import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/models/user/collection.dart';
import 'package:forkified/modules/home/user/collections/collcetion_details.dart';
import 'package:forkified/shared/components.dart';
import 'package:lottie/lottie.dart';
import '../../../main.dart';
import '../../../shared/colors.dart';
import '../../../shared/cubit/user/user_cubit.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    UserCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetUserDataLoading,
          builder: (context) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        cubit.user!.name!.toUpperCase(),
                        style: theme.displayLarge!
                            .copyWith(color: isDark! ? platinum : prussianBlue),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isDark! ? cerulian : flame,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Email ",
                                style: theme.displaySmall!.copyWith(
                                    color: isDark! ? platinum : prussianBlue),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              Text(
                                cubit.user!.email!,
                                style: theme.displaySmall!.copyWith(
                                    color: isDark! ? platinum : prussianBlue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Container(
                        color: isDark! ? cerulian : flame,
                        width: double.infinity,
                        height: 1,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.14,
                        mainAxisSpacing: size.height * 0.02,
                        childAspectRatio: 1 / 1,
                        children: List.generate(
                          cubit.user!.collections!.length,
                          (index) => buildcollection(
                            theme: theme,
                            size: size,
                            collection: cubit.user!.collections![index]!,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                    ],
                  ),
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

  Widget buildcollection({
    required TextTheme theme,
    required Size size,
    required Collection collection,
  }) =>
      GestureDetector(
        onTap: () {
          navigateTo(
            context,
            CollectionDetails(
              id: collection.id!,
            ),
          );
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  collection.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.displaySmall!
                      .copyWith(color: isDark! ? platinum : prussianBlue),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Image.asset(
                  "assets/images/paper.png",
                  width: size.width * 0.14,
                  height: size.height * 0.065,
                )
              ],
            ),
          ),
        ),
      );
}
