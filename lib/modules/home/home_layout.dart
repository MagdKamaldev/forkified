import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/home/drawer.dart';
import 'package:forkified/modules/search/search_screen.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import '../../shared/cubit/categories/categories_cubit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoriesCubit.get(context).getCategories();
    });

    CategoriesCubit.get(context).selectWelcomeTime();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = CategoriesCubit.get(context);
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;

    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Good ${cubit.welcomeText!}",
              style: theme.displayLarge,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    size: size.width * 0.07,
                  )),
              SizedBox(
                width: size.width * 0.03,
              ),
            ],
            toolbarHeight: size.height * 0.08,
          ),
          drawer: const AppDrawer(),
          body: cubit.screens[cubit.bottomNavBarIndex],
          bottomNavigationBar: BottomNavigationBar(
            iconSize: size.width * 0.07,
            backgroundColor: isDark! ? cerulian : flame,
            selectedItemColor: platinum,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.bottomNavBarIndex,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: "Add Collection"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "settings"),
            ],
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}

// Italian Cuisine
