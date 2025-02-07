import 'package:agrisync/admin/screen/admin_login_screen.dart';
import 'package:agrisync/admin/screen/admin_main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminMyApp extends StatelessWidget {
  const AdminMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(0.95),
            ),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'AgriSyncAdmin',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // check connection and return
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const AdminMainScreen();
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
            return const AdminLoginScreen();
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
