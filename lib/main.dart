import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/firebase_options.dart';
import 'package:forkified/modules/on_boarding/on_borading_screen.dart';
import 'package:forkified/shared/cubit/categories/categories_cubit.dart';
import 'package:forkified/shared/cubit/login/login_cubit.dart';
import 'package:forkified/shared/cubit/signup/signup_cubit.dart';
import 'package:forkified/shared/cubit/subcategory/subcategory_cubit.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/themes.dart';

String? token = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => SubcategoryCubit(),
        ),
      ],
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
