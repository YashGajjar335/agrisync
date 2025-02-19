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
            // Check connection state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              );
            }

            // Handle errors
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text(
                    'An error occurred: ${snapshot.error.toString()}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }

            // Check if the user is authenticated
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                // User is authenticated
                return const AdminMainScreen();
              } else {
                // User is not authenticated
                return const AdminLoginScreen();
              }
            }

            // Fallback for other states (e.g., ConnectionState.done)
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong. Please try again later.'),
              ),
            );
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
