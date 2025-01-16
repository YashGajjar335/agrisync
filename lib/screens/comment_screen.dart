import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  bool _isLike = false;
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "Comment"),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, item) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/app_logo_half.JPG"),
                  radius: 30,
                ),
                title: const TextLato(
                  text: "UserName",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                subtitle: const TextLato(
                    text: "Here is the comment for the perticular Thread"),
                trailing: InkWell(
                  onTap: () {
                    setState(() {
                      _isLike = !_isLike;
                    });
                  },
                  child: Icon(
                    _isLike ? Icons.favorite : Icons.favorite_border,
                    size: 30,
                  ),
                ),
              );
            }),
      ),
      bottomNavigationBar: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffix: IconButton(
              icon: const Icon(
                Icons.send_rounded,
                size: 30,
              ),
              onPressed: () {},
            )),
      ),
    );
  }
}
