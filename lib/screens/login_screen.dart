import 'package:agrisync/screens/signup_screen.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/animted_toggle_button.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    // double height = height(context);
    bool _password = false;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_screen_background.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: width(context) * 0.3,
                    top: height(context) * 0.1,
                    bottom: height(context) * 0.1),
                child: const Center(child: AgriSyncIcon(title: "LOGIN")),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon:
                            ImageAssets(imagePath: AgrisyncImageIcon().email),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.lato(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        contentPadding: EdgeInsets.all(15.0),
                        //  errorText: 'Email is required',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white24,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _password = !_password;
                            });
                          },
                          child: AnimatedToggleButton(
                            currIndex: _password,
                            icon1: Image.asset(AgrisyncImageIcon().openEye),
                            icon2: Image.asset(AgrisyncImageIcon().closeEye),
                          ),
                        ),
                        filled: true,
                        labelText: 'Password',
                        labelStyle: GoogleFonts.lato(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        // errorText: 'Password is required',
                        contentPadding: const EdgeInsets.all(15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 200, bottom: 10),
                        child: GestureDetector(
                            onTap: () {
                              print("forgot password");
                            },
                            child: TextLato(
                              text: "Forgot Password?",
                              fontColor: theme.primary,
                            ))),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LongButton(
                    width: double.infinity, name: "Sign In", onTap: () {}),
              ),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextLato(text: "Don't have account?"),
                  GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen())),
                      child: TextLato(
                        text: "Sign up",
                        fontColor: theme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
