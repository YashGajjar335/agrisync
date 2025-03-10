// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/model/comment.dart';
import 'package:agrisync/services/agri_tech_service.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/agri_tech_comment_card.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class AgriTechCommentScreen extends StatefulWidget {
  final String techId;
  const AgriTechCommentScreen({super.key, required this.techId});

  @override
  State<AgriTechCommentScreen> createState() => _AgriTechCommentScreenState();
}

class _AgriTechCommentScreenState extends State<AgriTechCommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: AgriSyncIcon(title: appLocalizations.comment),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Technology")
                    .doc(widget.techId)
                    .collection("Comments")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      int commentCount = snapshot.data!.size;

                      return commentCount == 0
                          ? Center(
                              child: TextLato(
                                text: appLocalizations.no_comment,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : ListView.builder(
                              itemCount: commentCount,
                              itemBuilder: (context, i) {
                                return AgriTechCommentCard(
                                    comment: Comment.fromSnap(
                                        snapshot.data!.docs[i]),
                                    techId: widget.techId);
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
                  return Center(
                    child: Column(
                      children: [
                        TextLato(
                          text: appLocalizations.somethingWrong,
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
                  label: TextLato(text: appLocalizations.add_comment),
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
                        showSnackBar(appLocalizations.enter_comment, context);
                      } else {
                        final res = await AgriTechService.instance
                            .uploadComment(widget.techId, comment);
                        if (res == null) {
                          showSnackBar(
                              appLocalizations.comment_uploaded, context);
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
