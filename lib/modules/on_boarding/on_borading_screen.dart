// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:forkified/modules/login/login_screen.dart';
import 'package:forkified/shared/components.dart';
import '../../shared/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> onBoardingData = [
    {
      'text': 'Welcome to Forkified!',
      'image': 'assets/images/logo.png',
      'color': cerulian,
    },
    {
      'text': 'Enter the ingredients you have',
      'image': 'assets/images/recipe.png',
      'color': cerulian,
    },
    {
      'text': 'Get recipes with YouTube tutorials',
      'image': 'assets/images/video.png',
      'color': cerulian,
    },
    {
      'text': 'Save your favorite recipes',
      'image': 'assets/images/save.png',
      'color': cerulian,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prussianBlue,
      appBar: AppBar(
        backgroundColor: prussianBlue,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Skip",
                style: TextStyle(color: platinum, fontSize: 18),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onBoardingData.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            onBoardingData[index]['image']!,
                            height: 300,
                            width: 300,
                          ),
                        ),
                        const SizedBox(height: 70),
                        Text(
                          onBoardingData[index]['text']!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onBoardingData.length,
                  (index) => buildDot(
                      index: index, color: onBoardingData[index]['color']),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                  width: 150,
                  height: 50,
                  child: defaultButton(
                      function: () {
                        if (_currentPage == onBoardingData.length - 1) {
                          navigateAndFinish(context, const LoginScreen());
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      context: context,
                      text: _currentPage == onBoardingData.length - 1
                          ? 'Get Started'
                          : "Next")

                  //  ElevatedButton(
                  //   onPressed: () {
                  //     if (_currentPage == onBoardingData.length - 1) {
                  //       Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const LoginScreen(),
                  //         ),
                  //       );
                  //     } else {
                  //       _pageController.nextPage(
                  //         duration: const Duration(milliseconds: 200),
                  //         curve: Curves.easeInOut,
                  //       );
                  //     }
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: cerulian,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //   ),
                  //   child: Text(_currentPage == onBoardingData.length - 1
                  //       ? 'Get Started'
                  //       : "Next"),
                  // ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot({required int index, required Color color}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? color : color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
