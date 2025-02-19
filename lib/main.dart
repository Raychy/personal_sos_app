// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_sos_app/route/routes.dart';
import 'package:personal_sos_app/screens/sliders/intro_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:personal_sos_app/screens/tab_screen.dart';
import 'package:personal_sos_app/services/background_task.dart';
import 'package:personal_sos_app/services/location_service.dart';
import 'package:personal_sos_app/services/providers/contact_provider.dart';
import 'package:personal_sos_app/services/providers/sms_provider.dart';
import 'package:personal_sos_app/services/providers/voice_service.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'services/providers/user_provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocationService().ensureLocationSaved();
Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // Set to false in production
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('yo'),
        Locale('ig'),
        Locale('ha'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const AppProviders(),
    ),
  );
}

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider()..loadUserDetails(),
        ),
        ChangeNotifierProvider(
          create: (context) => SMSProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider()..loadContactList(),
        ),
        ChangeNotifierProvider(
          create: (context) => BackgroundVoiceCommandProvider()..initVoiceListening(),
        ),
         ChangeNotifierProvider(
          create: (context) => VoiceToSpeechProvider(),
        ),
        //
      ],
      child: const MyApp(),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final username = context.watch<UserProvider>().username;
    String routeName =
        username.isNotEmpty ? TabScreen.routeName : IntroSliderScreen.routeName;

    return MaterialApp(
      title: 'Emergency SOS',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        ...context.localizationDelegates,
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primaryColor: const Color(0xFF191D3E),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.nunito(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: GoogleFonts.openSans(fontSize: 16),
          bodyMedium: GoogleFonts.openSans(fontSize: 14),
          bodySmall: GoogleFonts.openSans(fontSize: 12),
        ),
        useMaterial3: true,
      ),
      initialRoute: routeName,
      onGenerateRoute: Routes.routes,
    );
  }
}
