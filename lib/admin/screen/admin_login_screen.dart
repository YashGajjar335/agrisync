// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/admin/screen/admin_main_screen.dart';
import 'package:agrisync/admin/service/admin_login_service.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/animted_toggle_button.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? res;
  bool isLoad = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _hidePassword = true;

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
          child: Form(
            key: _formKey,
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
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Fill The Feild";
                          }
                          if (!emailValidator(value)) {
                            return "Enter valid Email";
                          }
                          return null;
                        },
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
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Fill the Feild";
                          }
                          return null;
                        },
                        maxLength: 8,
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          fillColor: Colors.white24,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            child: AnimatedToggleButton(
                              currIndex: !_hidePassword,
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
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LongButton(
                      width: double.infinity,
                      buttonText: "Sign In",
                      isLoading: isLoad,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          loginButtonFunction();
                        }
                      }),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginButtonFunction() async {
    setState(() {
      isLoad = true;
    });
    res = await AdminLoginService.instance
        .loginAdmin(_emailController.text, _passwordController.text);
    if (res == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AdminMainScreen()));
    } else {
      showSnackBar(res!, context);
    }
    setState(() {
      isLoad = false;
    });
  }
}
