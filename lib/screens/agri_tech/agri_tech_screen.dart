import 'package:agrisync/model/technology.dart';
import 'package:agrisync/screens/agri_tech/saved_technology.dart';
import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/screens/profile_screen.dart';
import 'package:agrisync/screens/agriConnect/save_thread_screen.dart';
import 'package:agrisync/services/login_services.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/screens/agri_tech/add_technology.dart';
import 'package:agrisync/screens/agriConnect/add_thread.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/agri_tech_card.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgriTechScreen extends StatefulWidget {
  const AgriTechScreen({super.key});

  @override
  State<AgriTechScreen> createState() => _AgriTechScreenState();
}

class _AgriTechScreenState extends State<AgriTechScreen> {
  bool isSpecialist = false;

  @override
  void initState() {
    checkSpecialist();
    super.initState();
  }

  checkSpecialist() async {
    final user = await AuthServices.instance.getCurrentUserDetail();
    setState(() {
      isSpecialist = user['isVerified'] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.border_all_rounded,
                  weight: 20,
                ),
                text: "All Technologies",
              ),
              Tab(
                icon: Icon(
                  Icons.bookmark_rounded,
                  weight: 20,
                ),
                text: "Saved Technologies",
              ),
            ],
          ),
          title: const AgriSyncIcon(
            title: "AgriTech",
            size: 30,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () => setState(() {}),
                icon: ImageAssets(
                  imagePath: AgrisyncImageIcon().refresh,
                  height: 32,
                  width: 32,
                ),
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
            AllTechnologies(),
            SavedTechnologiesScreen(),
          ],
        ),
        floatingActionButton: isSpecialist
            ? Padding(
                padding: const EdgeInsets.only(right: 08, bottom: 90),
                child: FloatingActionButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddTechnology())),
                  child: const Icon(
                    Icons.add,
                    size: 25,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class AllTechnologies extends StatefulWidget {
  const AllTechnologies({super.key});

  @override
  State<AllTechnologies> createState() => _AllTechnologiesState();
}

class _AllTechnologiesState extends State<AllTechnologies> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Technology").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final techCount = snapshot.data!.size;
              return techCount == 0
                  ? const Center(
                      child: TextLato(
                        text: "No Data Found..! ",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : ListView.builder(
                          itemCount: techCount,
                          itemBuilder: (context, item) {
                            return TechnologyCard(
                              technology: Technology.fromSnap(
                                  snapshot.data!.docs[item]),
                            );
                          }
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
                const TextLato(text: "Something Wrong..!"),
              ],
            ),
          );
        });
  }
}
