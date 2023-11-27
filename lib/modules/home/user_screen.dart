import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../main.dart';
import '../../shared/colors.dart';
import '../../shared/cubit/user/user_cubit.dart';

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
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      cubit.user!.name!.toUpperCase(),
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? platinum : prussianBlue),
                    ),
                    SizedBox(height: size.height*0.02,),
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
                              style: theme.displaySmall!
                                  .copyWith(color: isDark! ? platinum : prussianBlue),
                            ),
                            SizedBox(width: size.width*0.04,),
                            Text(
                              cubit.user!.email!,
                              style: theme.displaySmall!
                                  .copyWith(color: isDark! ? platinum : prussianBlue),
                            ),
                          ],
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
                child: Lottie.asset(isDark!
                    ? "assets/animations/forkified loading.json"
                    : "assets/animations/forkified loading orange.json")),
          ),
        );
      },
    );
  }
}
