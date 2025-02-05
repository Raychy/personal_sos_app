import 'package:flutter/material.dart';
import 'package:personal_sos_app/widgets/student_form.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = "/onboarding";

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/reg--bg.png',
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 100),
              child: StudentFormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
