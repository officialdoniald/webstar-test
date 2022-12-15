import 'package:flutter/material.dart';
import 'package:webstartest/screens/seasons/seasons_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:webstartest/services/season_api.dart';
import 'app_localizations.dart';
import 'language_constants.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void _setupServiceLocator() {
  getIt.registerSingleton<SeasonAPI>(SeasonAPI());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  _setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webstar Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: const [
        Locale("en", "US"),
        Locale("hu", "HU"),
      ],
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: const SeasonsScreen(),
    );
  }
}
