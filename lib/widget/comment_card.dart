import 'package:agrisync/model/comment.dart';
import 'package:agrisync/services/agri_connect_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  final String threadId;
  final Comment comment;
  const CommentCard({super.key, required this.comment, required this.threadId});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  Comment? comment;
  String userName = "userName";
  String profilepic = "";
  bool isLike = false;
  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  void loadData() async {
    comment = widget.comment;
    final user = await AgriConnectService.instance.getUser(comment!.uid);
    userName = await user['uname'];
    profilepic = await user['profilePic'];
    isLike = await AgriConnectService.instance
        .isCommentLike(widget.comment.commentId, widget.threadId);
    setState(() {});
  }

  void likeComment() async {
    final res = await AgriConnectService.instance
        .likeComment(widget.comment.commentId, widget.threadId);
    if (res == null) {
      setState(() {
        isLike = !isLike;
      });
    } else {
      showSnackBar(res, context);
    }
  }

  deleteComment() async {
    final res = await AgriConnectService.instance
        .deleteComment(comment!.commentId, widget.threadId, comment!.uid);
    print(res);
    showSnackBar(res ?? "Comment Deleted", context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (isSameUser(comment!.uid)) {
          alertMessage(
              "Delete Thread", "Do you really want to delete this Thread..?",
              () {
            deleteComment();
          }, context);
        }
      },
      child: ListTile(
          leading: profilepic.isNotEmpty
              ? StringImageInCircleAvatar(base64ImageString: profilepic)
              : const CircleAvatar(
                  backgroundImage: AssetImage("assets/app_logo_half.JPG"),
                  radius: 24,
                ),
          title: TextLato(
            text: userName,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          subtitle: TextLato(text: comment!.comment),
          trailing: IconButton(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isLike
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded),
                TextLato(
                  text: "${widget.comment.like.length} like",
                  fontSize: 10,
                )
              ],
            ),
            onPressed: () {
              likeComment();
            },
          )),
    );
  }
}
