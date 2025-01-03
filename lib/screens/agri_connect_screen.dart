import 'package:agrisync/screens/profile_screen.dart';
import 'package:agrisync/widget/thread_card.dart';
import 'package:flutter/material.dart';

class AgriConnectScreen extends StatefulWidget {
  const AgriConnectScreen({super.key});

  @override
  State<AgriConnectScreen> createState() => _AgriConnectScreenState();
}

class _AgriConnectScreenState extends State<AgriConnectScreen> {
  var itemcount = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newBar(),
      body: Container(
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  return const ThreadCard();
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        focusColor: Colors.greenAccent,
        backgroundColor: Colors.grey,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
        label: Text(
          'Add Post',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.post_add_sharp, color: Colors.white),
      ),
    );
  }

  AppBar newBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add_box_outlined,
            color: Colors.white,
          )),
      backgroundColor: Colors.blue,
      title: Text(
        'Social Page',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      elevation: 5,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
            ))
      ],
    );
  }
}
