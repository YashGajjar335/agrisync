import 'package:agrisync/model/comment.dart';
import 'package:agrisync/services/agri_tech_service.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AgriTechCommentCard extends StatefulWidget {
  final String techId;
  final Comment comment;
  const AgriTechCommentCard(
      {super.key, required this.comment, required this.techId});

  @override
  State<AgriTechCommentCard> createState() => _AgriTechCommentCardState();
}

class _AgriTechCommentCardState extends State<AgriTechCommentCard> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
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
    final user = await AgriTechService.instance.getUser(widget.comment.uid);
    userName = await user['uname'];
    profilepic = await user['profilePic'];
    isLike = await AgriTechService.instance.isLike(widget.techId);
    setState(() {});
  }

  void likeComment() async {
    final res = await AgriTechService.instance
        .likeComment(widget.comment.commentId, widget.techId);
    if (res == null) {
      setState(() {
        isLike = !isLike;
      });
    } else {
      showSnackBar(res, context);
    }
  }

  deleteComment() async {
    final res = await AgriTechService.instance
        .deleteComment(widget.comment.commentId, widget.techId, uid);
    print(res);
    showSnackBar(res ?? "Comment Deleted", context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (isSameUser(widget.comment.uid)) {
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
          subtitle: TextLato(text: widget.comment.comment),
          trailing: IconButton(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(!isLike
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded),
                TextLato(
                  text: "${widget.comment.like.length} like",
                  fontSize: 10,
                )
              ],
            ),
            onPressed: () => likeComment(),
          )),
    );
  }
}
