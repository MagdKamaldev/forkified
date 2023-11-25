import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:forkified/models/categories.model.dart';
import 'package:forkified/modules/home/drawer.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/cubit/app/app_cubit.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  String? welcomeText;

  final CarouselController _carouselController = CarouselController();

  int currentpage = 0;
  int bottomNavBarIndex = 0;

  List<BannerItem> banners = [
    BannerItem(
        image:
            'https://th.bing.com/th/id/OIP.7w2xnY9pv_uKUkaxbZTX0gHaEK?pid=ImgDet&rs=1'),
    BannerItem(
        image:
            'https://image.freepik.com/free-psd/recipes-banner-theme-design_23-2148645680.jpg'),
    BannerItem(
        image:
            'https://image.freepik.com/free-psd/recipes-banner-design_23-2148645679.jpg'),
    // Add more dummy data as needed
  ];

  @override
  void initState() {
    DateTime currentDateTime = DateTime.now();
    if (currentDateTime.hour < 12) {
      welcomeText = "Morning";
    } else if (currentDateTime.hour < 18) {
      welcomeText = "Afternoon";
    } else {
      welcomeText = "Evening";
    }
    AppCubit.get(context).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Good ${welcomeText!}",
          style: theme.displayLarge,
        ),
        toolbarHeight: size.height * 0.08,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Text(
                    "Trending Recipes",
                    style: theme.displayLarge,
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Icon(
                    Icons.trending_up_sharp,
                    color: platinum,
                    size: size.width * 0.07,
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CarouselSlider(
                    carouselController: _carouselController,
                    items: banners
                        .map(
                          (e) => Image(
                            image: NetworkImage(e.image),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 250.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentpage = index;
                        });
                      },
                      initialPage: 0,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Center(
                child: DotsIndicator(
                  dotsCount: banners.length,
                  position: currentpage,
                  decorator: DotsDecorator(
                    color: cerulian,
                    activeColor: nonPhotoBlue,
                    spacing: const EdgeInsets.all(6.0),
                    activeSize: const Size(9.5, 9.5),
                    size: const Size(7.0, 7.0),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                children: [
                  Text(
                    "Categroies",
                    style: theme.displayLarge,
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Icon(
                    Icons.category,
                    color: platinum,
                    size: size.width * 0.07,
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              ConditionalBuilder(
                condition: cubit.categories.isNotEmpty,
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
                builder: (context) => GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: size.width * 0.14,
                  mainAxisSpacing: size.height * 0.02,
                  childAspectRatio: 1 / 1,
                  children: List.generate(
                    cubit.categories.length,
                    (index) => buildCategory(
                        cubit.categories[index], context, index, size, theme),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: size.width * 0.07,
        backgroundColor: cerulian,
        selectedItemColor: platinum,
        currentIndex: bottomNavBarIndex,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "New"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
        ],
        onTap: (index) {
          setState(() {
            bottomNavBarIndex = index;
          });
        },
      ),
    );
  }

  Widget buildCategory(
          CategoryModel model, context, index, Size size, TextTheme theme) =>
      GestureDetector(
        onTap: () {
          
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "$serverIp${model.image.toString()}",
              width: size.width * 0.35,
              height: size.height * 0.1,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              model.name.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.displaySmall,
            )
          ],
        ),
      );
}

class BannerItem {
  final String image;
  BannerItem({required this.image});
}

class RecipeCategory {
  final String name;
  final String image;

  RecipeCategory({required this.name, required this.image});
}

// Italian Cuisine
