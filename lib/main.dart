import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_sos_app/route/routes.dart';
import 'package:personal_sos_app/screens/sliders/intro_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF191D3E),
        textTheme: TextTheme(
          displayLarge:
              GoogleFonts.nunito(fontSize: 50, fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: GoogleFonts.openSans(fontSize: 16),
          bodyMedium: GoogleFonts.openSans(
            fontSize: 14,
          ),
          bodySmall: GoogleFonts.openSans(fontSize: 12),
        ),
        useMaterial3: true,
      ),
      initialRoute: IntroSliderScreen.routeName,
      onGenerateRoute: Routes.routes,
    );
  }
}
