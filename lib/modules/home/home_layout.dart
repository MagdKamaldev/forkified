import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:forkified/modules/home/drawer.dart';
import 'package:forkified/shared/colors.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final CarouselController _carouselController = CarouselController();
  String? welcomeText;

  int currentpage = 0;

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

  DateTime currentDateTime = DateTime.now();
  void selectWelcomeTime() {
    if (currentDateTime.hour < 12) {
      welcomeText = "Morning";
    } else if (currentDateTime.hour < 18) {
      welcomeText = "Afternoon";
    } else {
      welcomeText = "Evening";
    }
  }

  @override
  void initState() {
    selectWelcomeTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
            DotsIndicator(
              dotsCount: banners.length,
              position: currentpage,
              decorator: DotsDecorator(
                color: nonPhotoBlue,
                activeColor: cerulian,
                spacing: const EdgeInsets.all(6.0),
                activeSize: const Size(9.5, 9.5),
                size: const Size(7.0, 7.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerItem {
  final String image;
  BannerItem({required this.image});
}
