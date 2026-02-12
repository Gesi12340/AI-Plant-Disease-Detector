import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/locale_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleController.loadLocale();
  final prefs = await SharedPreferences.getInstance();
  final userName = prefs.getString('userName');

  runApp(PlantDiseaseApp(initialRoute: userName == null ? '/login' : '/home'));
}

class PlantDiseaseApp extends StatelessWidget {
  final String initialRoute;
  const PlantDiseaseApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LocaleController.localeNotifier,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Plant Doctor',
          locale: locale,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2E7D32),
              brightness: Brightness.light,
            ),
            textTheme: GoogleFonts.outfitTextTheme(),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2E7D32),
              brightness: Brightness.dark,
            ),
            textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
          ),
          themeMode: ThemeMode.system,
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
          },
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('sw'),
          ],
        );
      },
    );
  }
}
