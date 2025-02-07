import 'package:agrisync/screens/crop/crop_detail_screen.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class CropListScreen extends StatefulWidget {
  final String crop;
  const CropListScreen({super.key, required this.crop});

  @override
  State<CropListScreen> createState() => _CropListScreenState();
}

class _CropListScreenState extends State<CropListScreen> {
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
          return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CropDetailScreen(crop: "${widget.crop}Name"))),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.lightGreen,
                child: Icon(
                  Icons.forest_rounded,
                  color: Colors.black,
                ),
              ),
              title: Text('${widget.crop}Name'),
              subtitle: Text('${widget.crop}Information'),
            ),
          );
        },
      ),
    );
  }
}
