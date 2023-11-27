import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/firebase_options.dart';
import 'package:forkified/modules/home/home_layout.dart';
import 'package:forkified/modules/login/login_screen.dart';
import 'package:forkified/modules/on_boarding/on_borading_screen.dart';
import 'package:forkified/shared/cubit/categories/categories_cubit.dart';
import 'package:forkified/shared/cubit/collections/collections_cubit.dart';
import 'package:forkified/shared/cubit/login/login_cubit.dart';
import 'package:forkified/shared/cubit/main/main_cubit.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';
import 'package:forkified/shared/cubit/signup/signup_cubit.dart';
import 'package:forkified/shared/cubit/subcategory/subcategory_cubit.dart';
import 'package:forkified/shared/cubit/user/user_cubit.dart';
import 'package:forkified/shared/networks/local/cache_helper.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:forkified/shared/themes.dart';

bool? isDark = false;
String? token = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget? widget;
  token = CacheHelper.getData(key: "token");
  String? start = CacheHelper.getData(key: "start");
  if (start == "home") {
    widget = const HomeLayout();
  } else if (start == "signIn") {
    widget = LoginScreen();
  } else {
    widget = const OnBoardingScreen();
  }
  isDark = CacheHelper.getData(key: "mode") ?? false;
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesCubit()..getCategories(),
        ),
        BlocProvider(
          create: (context) => RecipeCubit(),
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
         BlocProvider(
          create: (context) => CollectionsCubit(),
        ),
         BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => MainCubit(),
        ),
      ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: isDark! ? darkTheme : lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
