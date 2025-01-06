import 'package:agrisync/screens/profile_screen.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/thread_card.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: newBar(),
      body: GridView.builder(
          itemCount: 5,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 1,
            mainAxisExtent: 500,
          ),
          itemBuilder: (context, item) {
            return const ThreadCard();
          }),
    );
  }

  AppBar newBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const AgriSyncIcon(title: "AgriConnect"),
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
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen())),
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().profile,
              height: 30,
              width: 30,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(10)),
      ],
    );
  }
}
