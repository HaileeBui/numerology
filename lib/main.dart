import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numerology_app/providers/theme_model.dart';
import 'package:numerology_app/screen/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModal(),
        child: Consumer(builder: (context, ThemeModal themeNotifier, child) {
          return MaterialApp(
            title: 'Numerology',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              fontFamily: 'Roboto_Slab',
              scaffoldBackgroundColor:
                  themeNotifier.isDark ? Colors.amber : Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.transparent,
                //status bar color
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primarySwatch: Colors.purple,
            ),
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}
