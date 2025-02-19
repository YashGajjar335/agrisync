// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/screens/auth/email_verification_page.dart';
import 'package:agrisync/screens/auth/login_screen.dart';
import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/animted_toggle_button.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isSpecialist = false;
  bool _openfile = false;
  ImagePicker? image;
  bool _passShow = false;
  bool _passShow2 = false;
  bool _isLoad = false;

  String? doc;
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // App Logo
                      Center(
                        child: SizedBox(
                            height: 200,
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const Image(
                                  image:
                                      AssetImage("assets/app_logo_half.JPG")),
                            )),
                      ),
                      //  welcome message
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 100),
                        child: Text(
                          'Welcome to Sign Up',
                          style: GoogleFonts.lato(
                            fontSize: 35,
                            color: theme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // username
                      TextFormField(
                        validator: (value) {
                          return value == null || value.isEmpty
                              ? "Enter UserName"
                              : null;
                        },
                        keyboardType: TextInputType.text,
                        controller: _userNamecontroller,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          labelText: 'UserName',
                          labelStyle: GoogleFonts.lato(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white24,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email address
                      TextFormField(
                        validator: (value) {
                          return !emailValidator(_emailController.text)
                              ? "Enter Valid Email"
                              : null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // password
                      TextFormField(
                        validator: (value) {
                          return checkPassMatch(_passwordController.text,
                                  _passwordController2.text)
                              ? null
                              : "PassWord not match";
                        },
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        maxLength: 8,
                        obscureText: _passShow,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _passShow = !_passShow;
                              });
                            },
                            child: AnimatedToggleButton(
                                currIndex: _passShow,
                                icon1: ImageAssets(
                                  imagePath: AgrisyncImageIcon().openEye,
                                ),
                                icon2: ImageAssets(
                                    imagePath: AgrisyncImageIcon().closeEye)),
                          ),
                          labelText: 'Password',
                          labelStyle: GoogleFonts.lato(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white24,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      //re-type password
                      TextFormField(
                        validator: (value) {
                          return checkPassMatch(_passwordController.text,
                                  _passwordController2.text)
                              ? null
                              : "PassWord not match";
                        },
                        controller: _passwordController2,
                        keyboardType: TextInputType.visiblePassword,
                        maxLength: 8,
                        obscureText: _passShow2,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _passShow2 = !_passShow2;
                              });
                            },
                            child: AnimatedToggleButton(
                                currIndex: _passShow2,
                                icon1: ImageAssets(
                                  imagePath: AgrisyncImageIcon().openEye,
                                ),
                                icon2: ImageAssets(
                                    imagePath: AgrisyncImageIcon().closeEye)),
                          ),
                          labelText: 'Confirm-Password',
                          labelStyle: GoogleFonts.lato(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white24,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      //speacilist section
                      // image picker
                      if (_isSpecialist)
                        LongButton(
                          onTap: () async {
                            String? result =
                                await pickImageAndConvertToBase64();
                            // print("FILE : $result");

                            // print(result.files.first);

                            setState(() {
                              _openfile = true;
                              doc = result;
                            });
                          },
                          buttonText: 'Select file',
                          width: double.infinity,
                        ),
                      const SizedBox(height: 10),
                      // open image
                      if (_openfile && _isSpecialist && doc != null)
                        LongButton(
                          onTap: () {
                            showImage(context, doc!);
                          },
                          buttonText: 'Open file',
                          width: double.infinity,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Sign Up Button
              _isSpecialist
                  ? LongButton(
                      width: double.infinity,
                      isLoading: _isLoad,
                      buttonText: "Sign Up as Specialist",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (doc == null) {
                            showSnackBar("Upload your Document..!", context);
                          } else {
                            signUpFunctionSpecialist();
                          }
                        }
                      })
                  : LongButton(
                      width: double.infinity,
                      isLoading: _isLoad,
                      buttonText: "Sign Up",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          signUpFunctionFarmer();
                        }
                      }),
              const SizedBox(height: 20),
              // Sign up with
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSpecialist = !_isSpecialist;
                    _openfile = false;

                    doc = null;
                  });
                },
                child: Text(
                  _isSpecialist
                      ? 'Sign up with user '
                      : 'Sign up with specialist ',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    color: theme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // already have an account
              RichText(
                text: TextSpan(
                  text: 'Already have an account ? ',
                  style: GoogleFonts.lato(
                    color: theme.onSecondaryContainer,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                        text: 'Sign In',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color: theme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUpFunctionFarmer() async {
    setState(() {
      _isLoad = true;
    });
    String? res = await AuthServices.instance.signUpFarmer(
        _emailController.text,
        _passwordController.text,
        _userNamecontroller.text);
    setState(() {
      _isLoad = false;
    });
    if (res == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const EmailVerificationScreen()));
    } else {
      showSnackBar(res, context);
    }
  }

  Future<void> signUpFunctionSpecialist() async {
    setState(() {
      _isLoad = true;
    });
    String? res = await AuthServices.instance.signUpSpecialist(
        _userNamecontroller.text,
        _emailController.text,
        _passwordController.text,
        doc!);

    if (res == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const EmailVerificationScreen()));
    } else {
      showSnackBar(res, context);
    }

    setState(() {
      _isLoad = false;
    });
  }
}
