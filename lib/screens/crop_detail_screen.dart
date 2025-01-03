import 'package:agrisync/widget/flashy_bottom_navigation_bar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class CropDetailScreen extends StatefulWidget {
  final String crop;
  const CropDetailScreen({super.key, required this.crop});

  @override
  State<CropDetailScreen> createState() => _CropDetailScreenState();
}

class _CropDetailScreenState extends State<CropDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLato(
          text: widget.crop,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.lightGreen,
              child: Icon(
                Icons.forest_rounded,
                color: Colors.black,
              ),
            ),
            title: Text('${widget.crop}Name'),
            subtitle: Text('${widget.crop}Information'),
          );
        },
      ),
      bottomNavigationBar: const FlashyBottomNavigationBar(),
    );
  }
}
