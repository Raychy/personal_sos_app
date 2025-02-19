import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroSliderScreen extends StatefulWidget {
  static const routeName = "/intro-slider";
  const IntroSliderScreen({super.key});

  @override
  State<IntroSliderScreen> createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    const minHeight = 640;
    final screenHieght = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/intro-slider--bg.png',
                fit: BoxFit.cover,
              ),
            ),

            Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() => isLastPage = index == 2);
                    },
                    children: [
                      buildPage(
                        image: 'assets/images/slider-1.png',
                        title: "slider_one_title".tr(),
                        description:
                            "slider_one_body".tr(),
                        screenHieght: screenHieght,
                        minHeight: minHeight,
                      ),
                      buildPage(
                        image: 'assets/images/slider-2.png',
                        title:"slider_two_title".tr(),
                        description:
                          "slider_two_body".tr(),
                        screenHieght: screenHieght,
                        minHeight: minHeight,
                      ),
                      buildPage(
                        image: 'assets/images/slider-3.png',
                        title: "slider_three_title".tr(),
                        description:
                           "slider_three_body".tr(),
                        screenHieght: screenHieght,
                        minHeight: minHeight,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text("SKIP",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                    )),
                        onPressed: () => _controller.jumpToPage(2),
                      ),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.white,
                        ),
                      ),
                      TextButton(
                        child: const Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (isLastPage) {
                            Navigator.pushNamed(context, '/onboarding');
                          } else {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage(
      {required String image,
      required String title,
      required String description,
      screenHieght,
      minHeight}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: screenHieght > minHeight ? 30 : 20),
          Image.asset(image, height: 300),
          SizedBox(height: screenHieght > minHeight ? 160 : 100),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
