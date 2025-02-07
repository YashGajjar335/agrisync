import 'package:agrisync/model/technology.dart';
import 'package:agrisync/widget/agri_tech_card.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedTechnologiesScreen extends StatefulWidget {
  const SavedTechnologiesScreen({super.key});

  @override
  State<SavedTechnologiesScreen> createState() =>
      _SavedTechnologiesScreenState();
}

class _SavedTechnologiesScreenState extends State<SavedTechnologiesScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Technology")
            .where("save", arrayContains: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final techCount = snapshot.data!.size;
              return techCount == 0
                  ? const Center(
                      child: TextLato(
                        text: "No Technology Saved..!",
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: ListView.builder(
                          itemCount: techCount,
                          itemBuilder: (context, item) {
                            return TechnologyCard(
                              technology: Technology.fromSnap(
                                  snapshot.data!.docs[item]),
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
