import 'package:agrisync/screens/signup_screen.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/widget/animted_toggle_button.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/text_lato.dart';
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

  bool _showPass = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    // double height = height(context);
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
              Center(
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const Image(
                          image: AssetImage("assets/app_logo_half.JPG")),
                    )),
              ),
              const Center(
                child: TextLato(
                  text: "LOGIN",
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.lato(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        contentPadding: const EdgeInsets.all(15.0),
                        //  errorText: 'Email is required',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      maxLength: 8,
                      obscureText: _showPass,
                      decoration: InputDecoration(
                        fillColor: Colors.white24,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _showPass = !_showPass;
                            });
                          },
                          child: AnimatedToggleButton(
                            currIndex: _showPass,
                            icon1: ImageAssets(
                                imagePath: AgrisyncImageIcon().openEye),
                            icon2: ImageAssets(
                                imagePath: AgrisyncImageIcon().closeEye),
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
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LongButton(
                    width: double.infinity, name: "Sign In", onTap: () {}),
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextLato(text: "Don't have account?"),
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
