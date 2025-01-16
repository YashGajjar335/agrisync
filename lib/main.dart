import 'package:agrisync/utils/stripe_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'provider/app_lang_provider.dart';
import 'spash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await _setUp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppLangProvider(), // Initialize provider
      child: const MyApp(),
    ),
  );
}

Future<void> _setUp() async {
  String stripePublicKey = StripeKeys().publickey;
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  Stripe.publishableKey = stripePublicKey;
  // await Stripe.instance.applySettings();
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
      home: const SplashScreen(), // Navigate to splash screen
    );
  }
}
