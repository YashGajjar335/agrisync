// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/model/comment.dart';
import 'package:agrisync/services/agri_connect_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/comment_card.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgriConnectCommentScreen extends StatefulWidget {
  final String threadId;
  const AgriConnectCommentScreen({super.key, required this.threadId});

  @override
  State<AgriConnectCommentScreen> createState() =>
      _AgriConnectCommentScreenState();
}

class _AgriConnectCommentScreenState extends State<AgriConnectCommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "Comment"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Thread")
                    .doc(widget.threadId)
                    .collection("Comments")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      int commentCount = snapshot.data!.size;

                      return commentCount == 0
                          ? const Center(
                              child: TextLato(
                                text: "No Comment..",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : ListView.builder(
                              itemCount: commentCount,
                              itemBuilder: (context, item) {
                                return CommentCard(
                                  threadId: widget.threadId,
                                  comment: Comment.fromSnap(
                                      snapshot.data!.docs[item]),
                                );
                              });
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }
                  return const Center(
                    child: Column(
                      children: [
                        TextLato(
                          text: "Something Wrong..!",
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                  label: const TextLato(text: "add Comment"),
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.lightGreenAccent),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  suffix: IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () async {
                      String comment = _commentController.text.trim();
                      if (comment.isEmpty) {
                        showSnackBar("Enter the comment first", context);
                      } else {
                        final res = await AgriConnectService.instance
                            .uploadComment(widget.threadId, comment);
                        if (res == null) {
                          showSnackBar("Comment Uploded", context);
                          _commentController.clear();
                          FocusScope.of(context).unfocus();
                        } else {
                          showSnackBar(res, context);
                        }
                      }
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
