import 'package:agrisync/model/crop_model.dart';
import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/page_formate.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class PlantHealthReminder extends StatefulWidget {
  final String cropName;
  final List<CropStep> cropSteps;
  final List<String> cropImage;
  const PlantHealthReminder({
    super.key,
    required this.cropSteps,
    required this.cropName,
    required this.cropImage,
  });

  @override
  State<PlantHealthReminder> createState() => _PlantHealthReminderState();
}

class _PlantHealthReminderState extends State<PlantHealthReminder> {
  int pageNumber = 0;
  final PageController _pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          title: TextLato(
            text: "${appLocalizations.crophealthreminder} : ${widget.cropName}",
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
                    itemCount: widget.cropSteps.length,
                    itemBuilder: (context, i) {
                      return CropPageFormate(
                          imageString: widget.cropImage[i],
                          title: "${appLocalizations.step} : ${i + 1}",
                          description: widget.cropSteps[i].description);
                    },
                  ),
                ),
                pageNumber == 0
                    ? LongButton(
                        width: double.infinity,
                        buttonText: appLocalizations.getStart,
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
                              width: width(context) / 3,
                              buttonText: appLocalizations.previous,
                              onTap: () {
                                setState(() {
                                  _pagecontroller.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                });
                              },
                            ),
                            LongButton(
                              width: width(context) / 3,
                              buttonText:
                                  pageNumber == widget.cropSteps.length - 1
                                      ? appLocalizations.finish
                                      : appLocalizations.next,
                              onTap: () {
                                pageNumber == widget.cropSteps.length - 1
                                    ? Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen(
                                                  initPage: 0,
                                                )),
                                        (Route<dynamic> route) => false,
                                      )
                                    : setState(() {
                                        _pagecontroller.nextPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.linear);
                                      });
                              },
                            ),
                          ],
                        ),
                      )
              ],
            )));
  }
}
