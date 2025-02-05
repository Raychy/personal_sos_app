import 'package:flutter/material.dart';
import 'package:personal_sos_app/utils/colors.dart';
import 'package:personal_sos_app/widgets/sos_animated_button.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    const minHeight = 640;
    final screenHieght = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            "Hello, Cyberbizkit",
            style: theme.headlineLarge?.copyWith(
              color: const Color(0xFF191D3E),
            ),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
              ),
              Text(
                "Lagos, Nigeria",
                style: theme.bodyMedium?.copyWith(
                  color: const Color(0xFF191D3E),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHieght > minHeight ? 100 : 70),
        SOSAnimatedButtonWigdget(theme: theme),
      ],
    );
  }
}
