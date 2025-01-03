import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenTechnology extends StatelessWidget {
  const HomeScreenTechnology({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> slides = [
      {'image': 'assets/technology.png', 'title': 'Welcome to AgriSync'},
      {'image': 'assets/technology.png', 'title': 'Discover Farming Solutions'},
      {'image': 'assets/technology.png', 'title': 'Connect with Specialists'},
      {'image': 'assets/technology.png', 'title': 'Grow with Agri-Tech'},
    ];
    return Center(
      child: Column(
        children: [
          CarouselSlider(
            items: slides.map((slide) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            slide['image']!,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 10,
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 10),
                            child: Text(
                              slide['title']!,
                              style: GoogleFonts.lato(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
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
}
