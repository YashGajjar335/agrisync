import 'package:agrisync/model/farmer.dart';
import 'package:agrisync/model/specialist.dart';
import 'package:agrisync/model/technology.dart';
import 'package:agrisync/model/thread.dart';
import 'package:agrisync/screens/agriConnect/add_thread.dart';
import 'package:agrisync/screens/agri_tech/add_technology.dart';
import 'package:agrisync/screens/user/edit_profile.dart';
import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Farmer? farmer;
  Specialist? specialist;
  bool isLoad = false;

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  loadUser() async {
    AuthServices authServices = AuthServices.instance;
    final user = await authServices.getCurrentUserDetail();
    String role = await user["role"];
    print('role : $role');
    setState(() {
      role == "Farmer"
          ? farmer = Farmer.fromMap(user)
          : specialist = Specialist.fromMap(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: AgriSyncIcon(title: appLocalizations.profile),
      ),
      body: farmer == null && specialist == null
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : farmer != null && specialist == null
              ? FarmerDetail(farmer: farmer!)
              : SpecialistDetail(specialist: specialist!),
    );
  }
}

class FarmerDetail extends StatefulWidget {
  final Farmer farmer;
  const FarmerDetail({super.key, required this.farmer});

  @override
  State<FarmerDetail> createState() => _FarmerDetailState();
}

class SpecialistDetail extends StatefulWidget {
  final Specialist specialist;
  const SpecialistDetail({super.key, required this.specialist});

  @override
  State<SpecialistDetail> createState() => _SpecialistDetailState();
}

class _FarmerDetailState extends State<FarmerDetail> {
  int userThreads = 0;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    widget.farmer.profilePic.isEmpty
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/app_logo_half.JPG"),
                            radius: 30,
                          )
                        : StringImageInCircleAvatar(
                            base64ImageString: widget.farmer.profilePic,
                            radius: 30,
                          ),
                    const SizedBox(
                      width: 24,
                    ),
                    NumberAndText(
                        number: userThreads, lable: appLocalizations.thread),
                    NumberAndText(
                        number: widget.farmer.following.length,
                        lable: appLocalizations.following),
                    NumberAndText(
                        number: widget.farmer.followers.length,
                        lable: appLocalizations.followers),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextLato(
                  text: widget.farmer.uname,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LongButton(
                    width: width(context) * 0.4,
                    buttonText: appLocalizations.edit_profile,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditProfile()))),
                LongButton(
                    width: width(context) * 0.4,
                    buttonText: appLocalizations.add_thread,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const AddThread()))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Center(
                  child: TextLato(
                text: appLocalizations.your_thread,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
            ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Thread")
                    .where('uid', isEqualTo: widget.farmer.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      final int threadCount = snapshot.data!.size;
                      userThreads = threadCount;
                      return threadCount == 0
                          ? Center(
                              child: SizedBox(
                                // height: 400,
                                width: double.infinity,
                                child: TextLato(
                                  text: appLocalizations.no_thread_available,
                                ),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1 / 1,
                                crossAxisSpacing: 1,
                                mainAxisExtent: 100,
                              ),
                              itemCount: threadCount,
                              itemBuilder: (context, index) {
                                Thread thread =
                                    Thread.fromSnap(snapshot.data!.docs[index]);
                                return InkWell(
                                  onTap: () {
                                    showImage(context, thread.photoUrl);
                                  },
                                  child: Card(
                                    child: StringImage(
                                      base64ImageString: thread.photoUrl,
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              },
                            );
                    }
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 400,
                      width: 400,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const SizedBox(
                    height: 400,
                    width: 400,
                    child: Center(child: CircularProgressIndicator()),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class _SpecialistDetailState extends State<SpecialistDetail> {
  int userThreads = 0;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    widget.specialist.profilePic.isEmpty
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/app_logo_half.JPG"),
                            radius: 30,
                          )
                        : StringImageInCircleAvatar(
                            base64ImageString: widget.specialist.profilePic,
                            radius: 30,
                          ),
                    const SizedBox(
                      width: 24,
                    ),
                    NumberAndText(
                        number: userThreads, lable: appLocalizations.thread),
                    NumberAndText(
                        number: widget.specialist.following.length,
                        lable: appLocalizations.following),
                    NumberAndText(
                        number: widget.specialist.followers.length,
                        lable: appLocalizations.followers),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextLato(
                  text: widget.specialist.uname,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LongButton(
                    width: width(context) * 0.25,
                    buttonText: appLocalizations.edit_profile,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditProfile()))),
                LongButton(
                    width: width(context) * 0.25,
                    buttonText: appLocalizations.add_thread,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const AddThread()))),
                LongButton(
                    width: width(context) * 0.25,
                    buttonText: appLocalizations.add_technology,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AddTechnology()))),
              ],
            ),
            SizedBox(
              height: 500,
              child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: TabBar(tabs: [
                      TextLato(text: appLocalizations.your_thread),
                      TextLato(text: appLocalizations.your_technologies)
                    ]),
                    body: TabBarView(
                      children: [
                        // thread
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Thread")
                                .where('uid', isEqualTo: widget.specialist.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (snapshot.hasData) {
                                  final int threadCount = snapshot.data!.size;
                                  userThreads = threadCount;

                                  return threadCount == 0
                                      ? SizedBox(
                                          height: 400,
                                          width: double.infinity,
                                          child: TextLato(
                                            text: appLocalizations
                                                .no_thread_available,
                                          ),
                                        )
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1 / 1,
                                            crossAxisSpacing: 1,
                                            mainAxisExtent: 100,
                                          ),
                                          itemCount: threadCount,
                                          itemBuilder: (context, index) {
                                            Thread thread = Thread.fromSnap(
                                                snapshot.data!.docs[index]);
                                            return InkWell(
                                              onTap: () {
                                                showImage(
                                                    context, thread.photoUrl);
                                              },
                                              child: Card(
                                                child: StringImage(
                                                  base64ImageString:
                                                      thread.photoUrl,
                                                  fit: BoxFit.cover,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                }
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  height: 400,
                                  width: 400,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              return const SizedBox(
                                height: 400,
                                width: 400,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }),
                        // technologies
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Technology")
                                .where('uid', isEqualTo: widget.specialist.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (snapshot.hasData) {
                                  final int technologyCount =
                                      snapshot.data!.size;

                                  return technologyCount == 0
                                      ? SizedBox(
                                          height: 400,
                                          width: double.infinity,
                                          child: TextLato(
                                            text:
                                                appLocalizations.add_technology,
                                          ),
                                        )
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1 / 1,
                                            crossAxisSpacing: 1,
                                            mainAxisExtent: 100,
                                          ),
                                          itemCount: technologyCount,
                                          itemBuilder: (context, index) {
                                            Technology technology =
                                                Technology.fromSnap(
                                                    snapshot.data!.docs[index]);
                                            return InkWell(
                                              onTap: () {
                                                showImage(context,
                                                    technology.photoUrl);
                                              },
                                              child: Card(
                                                child: StringImage(
                                                  base64ImageString:
                                                      technology.photoUrl,
                                                  fit: BoxFit.cover,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                }
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  height: 400,
                                  width: 400,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              return const SizedBox(
                                height: 400,
                                width: 400,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class NumberAndText extends StatelessWidget {
  final int number;
  final String lable;
  const NumberAndText({super.key, required this.number, required this.lable});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextLato(
            text: number.toString(),
            fontSize: 20,
          ),
          TextLato(
            text: lable,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
