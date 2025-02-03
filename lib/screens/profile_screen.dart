import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, String>> listPost = [
    {'image': 'assets/shop1.jpg'},
    {'image': 'assets/farm.png'},
    {'image': 'assets/cal1.jpg'},
    {'image': 'assets/app_logo.png'},
    {'image': 'assets/app_logo_half.JPG'},
    {'image': 'assets/shop1.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "Profile"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/app_logo_half.JPG"),
                        radius: 30,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextLato(
                              text: "28",
                              fontSize: 20,
                            ),
                            TextLato(
                              text: "Post",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextLato(
                              text: "09",
                              fontSize: 20,
                            ),
                            TextLato(
                              text: "Followers",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextLato(
                              text: "10",
                              fontSize: 20,
                            ),
                            TextLato(
                              text: "Following",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: TextLato(
                    text: "UserName",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LongButton(
                      width: width(context) * 0.4,
                      buttonText: "Edit Profile",
                      onTap: () {}),
                  LongButton(
                      width: width(context) * 0.4,
                      buttonText: "Add Thread",
                      onTap: () {}),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: Center(
                    child: TextLato(
                  text: "Your Thread",
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
              ),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 1,
                  mainAxisExtent: 100,
                ),
                itemBuilder: (context, index) {
                  final post = listPost[index];
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      post['image']!,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                itemCount: listPost.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
