// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:personal_sos_app/services/model/contact_model.dart';
import 'package:personal_sos_app/services/preferences/preferences_service.dart';
import 'package:personal_sos_app/services/providers/sms_provider.dart';
import 'package:personal_sos_app/services/providers/voice_service.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:personal_sos_app/utils/colors.dart';

class SOSAnimatedButtonWigdget extends StatefulWidget {
  final theme;
  final lastLongitude;
  final lastLatitude;
  const SOSAnimatedButtonWigdget(
      {super.key, this.theme, this.lastLongitude, this.lastLatitude});

  @override
  State<SOSAnimatedButtonWigdget> createState() =>
      _SOSAnimatedButtonWigdgetState();
}

class _SOSAnimatedButtonWigdgetState extends State<SOSAnimatedButtonWigdget>
    with SingleTickerProviderStateMixin {
  late VoiceToSpeechProvider _voiceCommandService;
  double outerCircleSize = 270;
  double middleCircleSize = 220;
  double innerCircleSize = 170;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _voiceCommandService =
        Provider.of<VoiceToSpeechProvider>(context, listen: false);
    _voiceCommandService.initSpeech();
    _voiceCommandService.startListening();
    _voiceCommandService.onSOSDetected = () => _sendSOS(context);
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

  void _sendSOS(BuildContext context) async {
    final smsProvider = Provider.of<SMSProvider>(context, listen: false);
    List<ContactModel> emergencyContacts =
        await PreferencesService().getContactList();
    final userDetail = await PreferencesService().getUserDetails();
    String matricNo = userDetail['matricNo'] ?? "";

    if (emergencyContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No emergency contacts saved!")));
      return;
    }

    try {
      String locationUrl =
          "https://www.google.com/maps/search/?api=1&query=${widget.lastLatitude},${widget.lastLongitude}";
      String message =
          "HELP ME ($matricNo) IT'S AN EMERGENCY!! Please reach out ASAP to the location below\nLocation: $locationUrl";

      await smsProvider.sendEmergencySms(
        emergencyContacts,
        message,
      );
      if (smsProvider.successMessage.isNotEmpty) {
        showSuccessDialog(context, smsProvider.successMessage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error occurred!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending SMS: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isListening = Provider.of<VoiceToSpeechProvider>(context).isListening;
    return Column(
      children: [
        Center(
            child: InkWell(
          onTap: () {
            _sendSOS(context);
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
        )),
        const SizedBox(height: 20),
        // Voice listening status
        isListening
            ? const Text(
                "Listening for 'SOS' or 'Help'...",
                style: TextStyle(color: Colors.green, fontSize: 16),
              )
            : const Text(
                "Voice command inactive",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
      ],
    );
  }

  void showSuccessDialog(BuildContext context, successMessage) {
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
              Text(
                successMessage,
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
