// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:agrisync/screens/auth/login_screen.dart';
import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(minutes: 2), () {
      checkMaxTime();
      deleteCurrentUser();
    });
    user?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkMaxTime() async {
    print('time ended');
  }

  deleteCurrentUser() async {
    var auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    await FirebaseFirestore.instance.collection("Farmer").doc(uid).delete();
    await auth.currentUser!.delete();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  checkEmailVerified() async {
    await user?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      showSnackBar("Email Successfully Verified", context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainScreen()));
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              const Center(
                child: TextLato(
                  text: "Check your \n Email",
                  // textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: TextLato(
                    text: "We have sent you a Email on ${user!.email}",
                    // textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              )),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: TextLato(
                    text: "Verifying email....",
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  child: const TextLato(text: "Resend"),
                  onPressed: () {
                    try {
                      FirebaseAuth.instance.currentUser
                          ?.sendEmailVerification();
                    } catch (e) {
                      debugPrint("$e");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  child: const Text("Back"),
                  onPressed: () {
                    deleteCurrentUser();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
