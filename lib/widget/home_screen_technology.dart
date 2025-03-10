import 'package:agrisync/model/technology.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenTechnology extends StatelessWidget {
  const HomeScreenTechnology({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Technology")
          .orderBy("uploadAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final data = snapshot.data!.docs;
            // print(data);
            return Center(
              child: Column(
                children: [
                  CarouselSlider(
                    items: data.map((slide) {
                      Technology tech = Technology.fromSnap(slide);
                      // print(tech.uid);
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Stack(
                              children: [
                                StringImage(
                                  base64ImageString: tech.photoUrl,
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 10,
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10),
                                    child: Text(
                                      selectionColor: Colors.red,
                                      tech.title,
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 10),
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        // print("Page changed: $index");
                      },
                      enableInfiniteScroll: true,
                      initialPage: 0,
                    ),
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return SizedBox(
              height: 300,
              width: double.infinity,
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  TextLato(text: snapshot.error.toString())
                ],
              ),
            );
          }
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 300,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const SizedBox(
          height: 300,
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                TextLato(text: "Something wrong..!"),
              ],
            ),
          ),
        );
      },
    );
  }
}
