// ignore_for_file: missing_return, unused_local_variable

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_sos_app/screens/onboarding/onboard_screen.dart';
import 'package:personal_sos_app/screens/sliders/intro_slider.dart';
import 'package:personal_sos_app/screens/tab_screen.dart';

class Routes {
  static Route<dynamic> routes(RouteSettings settings) {
    var routeName = settings.name;
    var args = settings.arguments;
    switch (routeName) {
      case IntroSliderScreen.routeName:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const IntroSliderScreen(),
          isIos: true,
          duration: const Duration(milliseconds: 600),
        );

      case OnboardingScreen.routeName:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const OnboardingScreen(),
          isIos: true,
          duration: const Duration(milliseconds: 600),
        );
      case TabScreen.routeName:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const TabScreen(),
          isIos: true,
          duration: const Duration(milliseconds: 600),
        );
      default:
        return MaterialPageRoute(builder: (context) {
          return const IntroSliderScreen();
        });
    }
  }
}
//
