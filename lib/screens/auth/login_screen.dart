import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/screens/auth/signup_screen.dart';
import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/animted_toggle_button.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = AuthServices.instance;
  String? res;
  bool isLoad = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _showPass = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
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
                Center(
                  child: TextLato(
                    text: appLocalizations.login,
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
                            return appLocalizations.fillTheFeild;
                          }
                          if (!emailValidator(value)) {
                            return appLocalizations.enterValidEmail;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          labelText: appLocalizations.email,
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
                            return appLocalizations.fillTheFeild;
                          }
                          return null;
                        },
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
                          labelText: appLocalizations.password,
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
                          child: InkWell(
                              onTap: () {
                                String res =
                                    _auth.forgotPassword(_emailController.text);
                                showSnackBar(res, context);
                              },
                              child: TextLato(
                                text: appLocalizations.forgorPass,
                                color: theme.primary,
                              ))),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LongButton(
                      width: double.infinity,
                      isLoading: isLoad,
                      buttonText: appLocalizations.login,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          loginButtonFunction();
                        }
                      }),
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextLato(text: appLocalizations.doNotHaveAnAccount),
                    GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen())),
                        child: TextLato(
                          text: appLocalizations.signup,
                          color: theme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ))
                  ],
                )
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
    res =
        await _auth.loginUser(_emailController.text, _passwordController.text);
    // ignore: use_build_context_synchronously
    if (res == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainScreen()));
    } else {
      showSnackBar(res!, context);
    }
    setState(() {
      isLoad = false;
    });
  }
}
