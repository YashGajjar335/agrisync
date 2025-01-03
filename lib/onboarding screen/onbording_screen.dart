import 'package:agrisync/onboarding%20screen/page_formate.dart';
import 'package:agrisync/screens/home_screen.dart';
import 'package:agrisync/widget/colors.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    // ignore: unused_local_variable
    String buttonText = localizations.skip;
    return Scaffold(
      backgroundColor: whiteGreen,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                currentIndex = index;
                if (index == 5) {
                  buttonText = localizations.getStart;
                } else {
                  buttonText = localizations.skip;
                }
                setState(() {});
              },
              children: [
                ScreenDemo(
                    imagePath: "assets/page11.png",
                    title: localizations.cropcultivation,
                    description: localizations.cropcultivationdec),
                ScreenDemo(
                    imagePath: "assets/shop1.jpg",
                    title: localizations.agrimart,
                    description: localizations.agrimartdec),
                ScreenDemo(
                    imagePath: "assets/com11.jpg",
                    title: localizations.agrisynccommunication,
                    description: localizations.agrisynccommunicationdec),
                ScreenDemo(
                    imagePath: "assets/cal1.jpg",
                    title: localizations.crophealthreminder,
                    description: localizations.crophealthreminderdec),
                ScreenDemo(
                    imagePath: "assets/technology.jpg",
                    title: localizations.agritech,
                    description: localizations.agritechdec),
                ScreenDemo(
                    imagePath: "assets/lastpage3.jpg",
                    title: localizations.startMes,
                    description: " "),
              ],
            ),
          ),
          Container(
            alignment: const Alignment(1, 0),
            // padding: const EdgeInsets.only(top: 700),
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                    child: SmoothPageIndicator(
                        axisDirection: Axis.horizontal,
                        controller: pageController,
                        count: 6,
                        effect: const ExpandingDotsEffect(
                          spacing: 8.0,
                          radius: 10.0,
                          dotWidth: 7.0,
                          dotHeight: 7.0,
                          strokeWidth: 5.0,
                          dotColor: Colors.grey,
                          activeDotColor: Color.fromARGB(255, 6, 126, 70),
                          paintStyle: PaintingStyle.stroke,
                        )),
                  ),
                ),
                currentIndex == 5
                    ? Center(
                        child: LongButton(
                          width: 300,
                          name: localizations.getStart,
                          onTap: () async {
                            // child: button(330, 'Get Start', () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('isOnboarded', true);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen()),
                            );
                          },
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LongButton(
                              width: 130,
                              name: currentIndex == 0
                                  ? localizations.skip
                                  : localizations.previous,
                              onTap: () {
                                currentIndex == 0
                                    ? Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => const HomeScreen()),
                                      )
                                    : pageController
                                        .jumpToPage(currentIndex - 2);
                              }),
                          LongButton(
                              width: 130,
                              name: localizations.next,
                              onTap: () async {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeIn);
                              }),
                        ],
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
