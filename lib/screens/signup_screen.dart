import 'package:agrisync/screens/login_screen.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/widget/animted_toggle_button.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isSpecialist = false;
  bool _openfile = false;
  FilePickerResult? res;
  bool _passShow = false;
  //final TextEditingController _controller = TextEditingController();

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
                child: Column(
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
                    TextField(
                      keyboardType: TextInputType.text,
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
                    TextField(
                      keyboardType: TextInputType.emailAddress,
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
                    TextField(
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
                    const SizedBox(height: 30),
                    if (_isSpecialist)
                      LongButton(
                        onTap: () async {
                          final result = await FilePicker.platform
                              .pickFiles(allowMultiple: false);
                          if (result == null) return;
                          // print(result.files.first);

                          setState(() {
                            _openfile = true;
                            res = result;
                          });
                        },
                        name: 'Select file',
                        width: double.infinity,
                      ),
                    const SizedBox(height: 10),
                    if (_openfile && _isSpecialist)
                      LongButton(
                        onTap: () {
                          OpenFile.open(res?.files.first.path);
                        },
                        name: 'Open file',
                        width: double.infinity,
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              LongButton(width: double.infinity, name: "Sign Up", onTap: () {}),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSpecialist = !_isSpecialist;
                    _openfile = false;

                    res = null;
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
                            Navigator.push(
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
}
