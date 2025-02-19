import 'package:agrisync/model/farmer.dart';
import 'package:agrisync/model/specialist.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/animted_toggle_button.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewUsersList extends StatefulWidget {
  const ViewUsersList({super.key});

  @override
  State<ViewUsersList> createState() => _ViewUsersListState();
}

class _ViewUsersListState extends State<ViewUsersList> {
  bool isLoad = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "Users"),
      ),
      body: isLoad
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where("role", isEqualTo: "Specialist")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary),
                  );
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  // print(farmer.email);
                  // print("snap : $snap");
                  final snap = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, i) {
                        Specialist specialist =
                            Specialist.fromSnap(snapshot.data!.docs[i]);
                        print("Specislist Name : ${specialist.email}");
                        return ExpansionTile(
                          leading: specialist.profilePic.isEmpty
                              ? const CircleAvatar(child: Text("F"))
                              : StringImageInCircleAvatar(
                                  base64ImageString: specialist.profilePic),
                          title: Text(specialist.uname),
                          subtitle: Text(specialist.email),
                          children: [
                            LongButton(
                                width: 100,
                                buttonText: "view Doc",
                                onTap: () {
                                  showImage(context, specialist.validProof);
                                }),
                            SizedBox(
                              height: 70,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const TextLato(
                                      text: "Confirm Specialist? : ",
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          try {
                                            setState(() {
                                              isLoad = false;
                                            });
                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(specialist.uid)
                                                .update({
                                              "isVerified":
                                                  !specialist.isVerified,
                                            });
                                            print("done");
                                            setState(() {
                                              isLoad = true;
                                            });
                                          } catch (e) {
                                            print("Error $e");
                                          }
                                        },
                                        child: AnimatedToggleButton(
                                            currIndex: specialist.isVerified,
                                            icon1: const Icon(
                                              Icons.check,
                                              size: 30,
                                              weight: 20,
                                            ),
                                            icon2: const Icon(
                                              Icons.close,
                                              size: 30,
                                              weight: 20,
                                            )))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                }
                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary),
            ),
    );
  }
}
