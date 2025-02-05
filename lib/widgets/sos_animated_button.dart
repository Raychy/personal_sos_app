// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:personal_sos_app/utils/colors.dart';

class SOSAnimatedButtonWigdget extends StatefulWidget {
  final theme;
  const SOSAnimatedButtonWigdget({super.key, this.theme});

  @override
  State<SOSAnimatedButtonWigdget> createState() =>
      _SOSAnimatedButtonWigdgetState();
}

class _SOSAnimatedButtonWigdgetState extends State<SOSAnimatedButtonWigdget>
    with SingleTickerProviderStateMixin {
  double outerCircleSize = 270;
  double middleCircleSize = 220;
  double innerCircleSize = 170;

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Start animation timer
    _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      setState(() {
        outerCircleSize = (outerCircleSize == 270) ? 250 : 270;
        middleCircleSize = (middleCircleSize == 220) ? 200 : 220;
        innerCircleSize = (innerCircleSize == 170) ? 150 : 170;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          showSuccessDialog(context);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              width: outerCircleSize,
              height: outerCircleSize,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              width: middleCircleSize,
              height: middleCircleSize,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              width: innerCircleSize,
              height: innerCircleSize,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              'SOS',
              style: widget.theme.displayLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Load and display the success GIF
              Image.asset(
                'assets/gifs/success.gif',
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Success!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your location was sent successfully.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
