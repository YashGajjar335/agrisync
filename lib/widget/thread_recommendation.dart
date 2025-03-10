import 'package:agrisync/model/thread.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/thread_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThreadRecommendation extends StatelessWidget {
  const ThreadRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Thread")
              .orderBy("uploadAt", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                final int count = snapshot.data!.size.toInt();
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: count <= 5 ? count : 5,
                    itemBuilder: (context, item) {
                      return SizedBox(
                        width: width(context) - 20,
                        child: ThreadCard(
                            thread: Thread.fromSnap(snapshot.data!.docs[item])),
                      );
                    });
              }
              if (snapshot.hasError) {
                return SizedBox(
                  child: Center(
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        TextLato(text: snapshot.error.toString())
                      ],
                    ),
                  ),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SizedBox(
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    TextLato(text: "Something wrong..!"),
                  ],
                ),
              ),
            );
          }),
    );
    // return SingleChildScrollView(
    //     child: CarouselSlider(
    //   options: CarouselOptions(
    //     height: 550,
    //     initialPage: 1,
    //   ),
    //   items: List.generate(5, (index) {
    //     return Container(
    //       padding: const EdgeInsets.all(16),
    //       height: 550,
    //       // width: 423,
    //       child: const Center(
    //         child: CircularProgressIndicator(),
    //       ),
    //       // child: ThreadCard(
    //       //   snap: FirebaseFirestore.instance.collection("Thread").where(),
    //       // ),
    //     );
    //   }),
    // ));

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

    // );
  }
}
