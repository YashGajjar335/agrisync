import 'package:agrisync/screens/login_screen.dart';
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
  bool _isTextFieldVisible = false;
  bool _openfile = false;
  FilePickerResult? res;
  //final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_screen_background.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 100, 20, 50),
                      child: Text(
                        'Welcome to Sign Up',
                        style: GoogleFonts.lato(
                          fontSize: 30,
                          color: Color.fromARGB(255, 7, 101, 10),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.people),
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
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
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
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility),
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
                    SizedBox(height: 30),
                    if (_isTextFieldVisible)
                      LongButton(
                        onTap: () async {
                          final result = await FilePicker.platform
                              .pickFiles(allowMultiple: false);
                          if (result == null) return;
                          print(result.files.first);
                          setState(() {
                            _openfile = true;
                            res = result;
                          });
                        },
                        name: 'Select file',
                        width: double.infinity,
                      ),
                    const SizedBox(height: 10),
                    if (_openfile && _isTextFieldVisible)
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
              SizedBox(
                height: 20,
              ),
              LongButton(width: double.infinity, name: "Sign Up", onTap: () {}),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isTextFieldVisible = !_isTextFieldVisible;
                    _openfile = false;

                    res = null;
                  });
                },
                child: Text(
                  _isTextFieldVisible
                      ? 'Sign up with user '
                      : 'Sign up with specialist ',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: 'Already have an account ? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                        text: 'Sign In',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          }),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 50))
            ],
          ),
        ),
      ),
    );
  }
}
