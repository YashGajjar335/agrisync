import 'package:agrisync/admin/admin_app.dart';
import 'package:agrisync/screens/auth/email_verification_page.dart';
import 'package:agrisync/screens/auth/login_screen.dart';
import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/utils/stripe_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'provider/app_lang_provider.dart';
import 'spash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await _setUp();
  // // for_admin
  runApp(const AdminMyApp());
  // // ----------------------------------------------------------
  // // for user
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (_) => AppLangProvider(), // Initialize provider
  //     child: const MyApp(),
  //   ),
  // );
  // // -------------------------------------------------------------
}

Future<void> _setUp() async {
  String stripePublicKey = StripeKeys().publickey;
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  Stripe.publishableKey = stripePublicKey;
  // await Stripe.instance.applySettings();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyC88c4Zmuy7E71ocZ2xhxAYuEtLe1R0QV8",
    appId: "1082811344782",
    messagingSenderId: "1082811344782",
    projectId: "agrisync-b3851",
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appLangProvider = Provider.of<AppLangProvider>(context);

    return MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(0.95),
            ),
            child: child!,
          );
        },
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: appLangProvider.lan, // Use locale from AppLangProvider
        supportedLocales: const [
          Locale('en'), // English
          Locale('hi'), // Hindi
          Locale('gu'), // Gujarati
        ],
        debugShowCheckedModeBanner: false,
        title: 'AgriSync',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // check connection and return
            // bool emailverification = snapshot.
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const SplashScreen(
                  nextScreen: MainScreen(),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text(snapshot.error.toString()),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    // CircularProgressIndicator
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                );
              }
            }
            return const SplashScreen(nextScreen: LoginScreen());
          },
        )
        // SplashScreen(
        //   nextScreen: LoginServices.instance.checkLogin()
        //       ? const MainScreen()
        //       : const LoginScreen(),
        // ), // Navigate to splash screen
        );
  }
}
