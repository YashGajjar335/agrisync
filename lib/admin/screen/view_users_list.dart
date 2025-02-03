import 'package:agrisync/model/farmer.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewUsersList extends StatefulWidget {
  const ViewUsersList({super.key});

  @override
  State<ViewUsersList> createState() => _ViewUsersListState();
}

class _ViewUsersListState extends State<ViewUsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "Users"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('farmer').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            // print(farmer.email);
            final snap = snapshot.data!.docs;
            print("snap : $snap");
            return ListView.builder(
                itemCount: snap.length,
                itemBuilder: (context, i) {
                  Farmer farmer =
                      Farmer.fromSnap(snapshot.data!.docs.elementAt(i));

                  return ListTile(
                    leading: farmer.profilePic.isEmpty
                        ? const CircleAvatar(child: Text("F"))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: StringImage(
                                base64ImageString: farmer.profilePic)),
                    title: Text(farmer.uname),
                    subtitle: Text(farmer.email),
                  );
                });
          }
          return const Center(
            child: Text("Hello please wait"),
          );
        },
      ),
    );
  }
}
