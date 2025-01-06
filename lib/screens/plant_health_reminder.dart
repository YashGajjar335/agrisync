import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/page_formate.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class PlantHealthReminder extends StatefulWidget {
  final String cropName;
  final List<String> cropSteps;
  const PlantHealthReminder(
      {super.key, required this.cropSteps, required this.cropName});

  @override
  State<PlantHealthReminder> createState() => _PlantHealthReminderState();
}

class _PlantHealthReminderState extends State<PlantHealthReminder> {
  int pageNumber = 0;
  final PageController _pagecontroller = PageController();

  List<String> cropStep = [
    "Select Suitable Land: Choose well-drained loamy or clayey soil with a pH between 6 and 7.5.",
    "Prepare the Soil: Till the land to a fine tilth and incorporate organic matter or compost to enhance fertility.",
    "Choose the Right Variety: Select a wheat variety suitable for your region's climate and soil conditions.",
    "Sow the Seeds: Plant seeds at a depth of 1-2 inches, maintaining a spacing of 6-8 inches between rows. Optimal sowing time is October-November.",
    "Irrigation: Provide timely irrigation, especially during critical growth stages like tillering, jointing, and grain filling.",
    "Weed Management: Regularly monitor and control weeds through manual weeding or appropriate herbicides.",
    "Fertilization: Apply recommended doses of nitrogen, phosphorus, and potassium based on soil test results.",
    "Pest and Disease Control: Monitor for common pests and diseases; use integrated pest management practices as needed.",
    "Harvesting: Harvest when grains are hard and moisture content is around 14%. This typically occurs 4-5 months after sowing, around March-April.",
    "Post-Harvest Handling: Thresh, clean, and store grains in a cool, dry place to maintain quality."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextLato(
            text: "Plant Health Reminder for : ${widget.cropName}",
            // fon: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0 * 2),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pagecontroller,
                  onPageChanged: (val) => setState(() {
                    // print(val);
                    // print(cropStep.length);
                    pageNumber = val;
                  }),
                  itemCount: cropStep.length,
                  itemBuilder: (context, i) {
                    return PageFormate(
                        imagePath: "assets/farm.png",
                        title: "Step: ${i + 1}",
                        description: cropStep[i]);
                  },
                ),
              ),
              pageNumber == 0
                  ? LongButton(
                      width: double.infinity,
                      name: "Start",
                      onTap: () {
                        setState(() {
                          _pagecontroller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear);
                        });
                      })
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LongButton(
                            width: width(context) * 0.4,
                            name: "Previous ",
                            onTap: () {
                              setState(() {
                                _pagecontroller.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              });
                            },
                          ),
                          LongButton(
                            width: width(context) * 0.4,
                            name: pageNumber == cropStep.length - 1
                                ? "Finish"
                                : "Next ",
                            onTap: () {
                              pageNumber == cropStep.length - 1
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreen(
                                                initPage: 0,
                                              )))
                                  : setState(() {
                                      _pagecontroller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    });
                            },
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ));
  }
}
