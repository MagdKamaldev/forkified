import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/login/login_screen.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/main/main_cubit.dart';
import 'package:forkified/shared/networks/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              "Settings",
              style: theme.displayLarge,
            ),
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dark Mode",
                          style: theme.displayMedium,
                        ),
                        Switch(
                          value: isDark!,
                          onChanged: (bool value) {
                            cubit.changemode(value);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    defaultButton(
                        function: () {
                          navigateAndFinish(context, LoginScreen());
                          CacheHelper.removeData(key: "token");
                          token = "";
                        },
                        context: context,
                        text: "Logout",
                        width: size.width * 0.8),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
