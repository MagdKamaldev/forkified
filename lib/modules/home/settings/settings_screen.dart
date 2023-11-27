import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/shared/cubit/main/main_cubit.dart';

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
            title: Text("Settings",style: theme.displayLarge,),
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Row(
                children: [
                  Text("Dark Mode",style: theme.displayMedium,),
                  Switch(
                    value: isDark!,
                    onChanged: (bool value) {
                      cubit.changemode(value);
                    },
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
