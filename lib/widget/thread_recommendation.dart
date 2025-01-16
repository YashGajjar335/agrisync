import 'package:agrisync/widget/thread_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ThreadRecommendation extends StatelessWidget {
  const ThreadRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: CarouselSlider(
      options: CarouselOptions(
        height: 550,
        initialPage: 1,
      ),
      items: List.generate(5, (index) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 550,
          // width: 423,
          child: const ThreadCard(),
        );
      }),
    )

        // Row(
        //   children: List.generate(
        //     5,
        //     (index) {
        //       return Container(
        //         padding: const EdgeInsets.all(16),
        //         height: 550,
        //         width: 423,
        //         child: const ThreadCard(),
        //       );
        //     },
        //   ),
        // children: [
        //   GridView.builder(
        //     shrinkWrap: true,
        //     itemCount: 5,
        //     scrollDirection: Axis.horizontal,
        //     physics: const NeverScrollableScrollPhysics(),
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 1,
        //       // mainAxisSpacing: 300,
        //       // crossAxisSpacing: 300,
        //       childAspectRatio: 0.85,
        //     ),
        //     itemBuilder: (context, index) {
        //       return const ThreadCard();
        //     },
        //   ),
        // ],

        );
  }
}
