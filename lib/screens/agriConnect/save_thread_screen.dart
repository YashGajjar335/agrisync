import 'package:agrisync/model/thread.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/thread_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SaveThreadScreen extends StatefulWidget {
  const SaveThreadScreen({super.key});

  @override
  State<SaveThreadScreen> createState() => _SaveThreadScreenState();
}

class _SaveThreadScreenState extends State<SaveThreadScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Thread")
            .where("save", arrayContains: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final threadCount = snapshot.data!.size;
              return threadCount == 0
                  ? const Center(
                      child: TextLato(
                        text: "No Thread Saved..!",
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: ListView.builder(
                          itemCount: threadCount,
                          // gridDelegate:
                          //     const SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 1,
                          //   childAspectRatio: 1 / 1,
                          //   crossAxisSpacing: 1,
                          //   mainAxisExtent: 500,
                          // ),
                          itemBuilder: (context, item) {
                            return ThreadCard(
                              thread:
                                  Thread.fromSnap(snapshot.data!.docs[item]),
                            );
                          }),
                    );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    TextLato(text: "${snapshot.error}"),
                  ],
                ),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }
          return Center(
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
                const TextLato(text: "Something went wrong..!"),
              ],
            ),
          );
        });
  }
}
