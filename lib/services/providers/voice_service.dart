// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceToSpeechProvider with ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  bool isInitialized = false;
  Function()? onSOSDetected; // Callback function for emergency

  Future<void> initSpeech() async {
    isInitialized = await _speech.initialize(
      onStatus: (status) {
        print("🎤 Speech status: $status");
        if (status == "done") {
          _restartListening();
        }
      },
      onError: (error) {
        print("❌ Speech error: $error");
        _restartListening();
      },
    );

    if (isInitialized) {
      print("✅ Speech recognition initialized!");
      startListening(); // Start listening immediately
    } else {
      print("❌ Speech recognition failed to initialize.");
    }
  }

  void startListening() async {
    if (!isInitialized || _speech.isListening) return;

    await _speech.listen(
      onResult: (result) {
        String command = result.recognizedWords.toLowerCase();
        print("🎤 Recognized: $command");

        if (command.contains("sos") || command.contains("help me") || command.contains("emergency")) {
          print("🚨 Emergency command detected! Sending SOS...");
          onSOSDetected?.call(); // Trigger SOS function
          stopListening();
        }
      },
    );
    isListening = true;
    notifyListeners();
  }

  void stopListening() {
    _speech.stop();
    isListening = false;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), startListening); // Restart listening
  }

  void _restartListening() {
    Future.delayed(const Duration(seconds: 2), startListening);
  }
}
