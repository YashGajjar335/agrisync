import 'package:agrisync/screens/onbording_screen.dart';
import 'package:agrisync/screens/home_screen.dart';
import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/widget/colors.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isOnboarded = false;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  void _setup() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isOnboarded = prefs.getBool('isOnboarded') ?? false;
    });
  }

  Widget _nextScreen() {
    // print("TEST: ${isOnboarded}");
    if (isOnboarded) {
      return const MainScreen();
    } else {
      return const OnBordingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 30.0),
            duration: const Duration(seconds: 3),
            builder: (BuildContext context, double value, Widget? child) {
              return Text(
                'AgrySync',
                style: GoogleFonts.lato(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: bottomGreen,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
          Expanded(
            child: Center(
              child:
                  LottieBuilder.asset("assets/Animation - 1723701867292.json"),
            ),
          )
        ],
      ),
      nextScreen: _nextScreen(),
      splashIconSize: 450,
      backgroundColor: whiteGreen,
    );
  }
}
