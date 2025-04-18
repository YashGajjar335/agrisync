import 'package:agrisync/model/thread.dart';
import 'package:agrisync/screens/user/profile_screen.dart';
import 'package:agrisync/screens/agriConnect/save_thread_screen.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/screens/agriConnect/add_thread.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/thread_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class AgriConnectScreen extends StatefulWidget {
  const AgriConnectScreen({super.key});

  @override
  State<AgriConnectScreen> createState() => _AgriConnectScreenState();
}

class _AgriConnectScreenState extends State<AgriConnectScreen> {
  var itemcount = 10;

  get itemBuilder => null;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(
                  Icons.border_all_rounded,
                  weight: 20,
                ),
                text: appLocalizations.all_threads,
              ),
              Tab(
                icon: const Icon(
                  Icons.bookmark,
                  weight: 20,
                ),
                text: appLocalizations.saved_threads,
              ),
            ],
          ),
          title: AgriSyncIcon(
            title: appLocalizations.agriconnect,
            size: 25,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageAssets(
                imagePath: AgrisyncImageIcon().refresh,
                height: 32,
                width: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen())),
                child: ImageAssets(
                  imagePath: AgrisyncImageIcon().profile,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
          ],
        ),
        body: const TabBarView(
          children: [
            AllThread(),
            SaveThreadScreen(),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70, right: 16),
          child: FloatingActionButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AddThread())),
            child: Icon(
              Icons.add,
              size: 25,
              semanticLabel: appLocalizations.add_thread,
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   onTap: (value) {
        //     if (value == 0) {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (_) => const AddThread()));
        //     } else if (value == 1) {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (_) => const SaveThreadScreen()));
        //     }
        //   },
        //   items: const [
        //     BottomNavigationBarItem(
        //         icon: const Icon(
        //           Icons.add,
        //           weight: 20,
        //         ),
        //         label: "Add Thread"),
        //     const BottomNavigationBarItem(
        //         icon: Icon(
        //           Icons.bookmark,
        //           weight: 20,
        //         ),
        //         label: "Saved Thread"),
        //   ],
        // ),
      ),
    );
  }
}

class AllThread extends StatefulWidget {
  const AllThread({super.key});

  @override
  State<AllThread> createState() => _AllThreadState();
}

class _AllThreadState extends State<AllThread> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Thread").snapshots(),
        builder: (context, snapshot) {
          // print(snapshot);
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final threadCount = snapshot.data!.size;
              return threadCount == 0
                  ? Center(
                      child: TextLato(
                        text: appLocalizations.no_thread_available,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: ListView.builder(
                          itemCount: threadCount,
                          itemBuilder: (context, index) {
                            return ThreadCard(
                              thread:
                                  Thread.fromSnap(snapshot.data!.docs[index]),
                            );
                          }),
                    );
            } else if (snapshot.hasError) {
              final snapError = snapshot.error;
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    TextLato(text: "$snapError."),
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
                TextLato(text: appLocalizations.somethingWrong),
              ],
            ),
          );
        });
  }
}
