import 'package:agrisync/model/thread.dart';
import 'package:agrisync/screens/agriConnect/comment_screen.dart';
import 'package:agrisync/services/agri_connect_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThreadCard extends StatefulWidget {
  final Thread thread;
  const ThreadCard({
    super.key,
    required this.thread,
  });

  @override
  State<ThreadCard> createState() => _ThreadCardState();
}

class _ThreadCardState extends State<ThreadCard> {
  final AgriConnectService agriConnect = AgriConnectService.instance;
  // String userName = "userName";
  // String photoUrl = "";
  bool isLiked = false;
  bool isSaved = false;
  bool isLoad = true;
  int totalLike = 0;

  @override
  void initState() {
    loadThreadData();
    loadUserData();
    super.initState();
  }

  void loadUserData() async {
    final user = await agriConnect.getUser(widget.thread.uid);
    widget.thread.userName = await user['uname'];
    widget.thread.userProfilePic = await user['profilePic'];
    if (mounted) {
      setState(() {});
    }
  }

  void loadThreadData() {
    isLiked = widget.thread.isLiked;
    isSaved = widget.thread.isSaved;
    totalLike = widget.thread.totalLike;
    if (mounted) {
      setState(() {
        isLoad = false;
      });
    }
    // isLiked = await agriConnect.isLike(widget.thread.threadId);
    // isSaved = await agriConnect.isSaved(widget.thread.threadId);
    // print(thread.threadId);
    // if (mounted) {
    //   setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      shadowColor: Theme.of(context).colorScheme.secondary,
      surfaceTintColor: Theme.of(context).colorScheme.secondaryContainer,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            threadHeader(appLocalizations),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: StringImage(
                base64ImageString: widget.thread.photoUrl,
                fit: BoxFit.contain,
                height: 280,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 5),
            threadBottom(appLocalizations),
          ],
        ),
      ),
    );
  }

  void likeThread() async {
    bool newLikedState = !isLiked;
    setState(() => isLiked = newLikedState);

    final res = await agriConnect.likeThread(widget.thread.threadId);
    if (mounted && res != null) {
      // setState(() {}); // Update UI only if necessary
    }
  }

  // void saveThreads() async {
  //   bool newSavedState = !isSaved;
  //   setState(() => isSaved = newSavedState);

  //   final res = await agriConnect.savedThread(widget.thread.threadId);
  //   if (mounted && res != null) {
  //     // setState(() {});
  //   }
  // }

  void saveThreads() async {
    // Toggle locally for faster UI response
    final previousState = isSaved; // Store previous state
    setState(() => isSaved = !isSaved);

    // Call Firebase and revert on failure
    final result = await agriConnect.savedThread(widget.thread.threadId);
    if (mounted && result == null) {
      setState(() {
        isSaved = previousState;
        isLoad = false;
      }); // Revert if failed
    }
  }

  Widget threadBottom(AppLocalizations applocalization) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextLato(text: widget.thread.description),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                iconSize: 30,
                icon: Column(
                  children: [
                    Icon(
                      isLiked
                          ? Icons.thumb_up_alt
                          : Icons.thumb_up_alt_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    TextLato(
                      text: "$totalLike ${applocalization.like}",
                      paddingAll: 0.0,
                    ),
                  ],
                ),
                onPressed: () {
                  if (!isLiked) {
                    totalLike += 1;
                  } else {
                    totalLike -= 1;
                  }
                  likeThread();
                },
              ),
              const Padding(padding: EdgeInsets.all(4)),
              IconButton(
                iconSize: 30,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgriConnectCommentScreen(
                        threadId: widget.thread.threadId,
                      ),
                    ),
                  );
                },
                icon: Column(
                  children: [
                    Icon(Icons.comment_rounded,
                        color: Theme.of(context).colorScheme.primary),
                    TextLato(
                      text: applocalization.comment,
                      paddingAll: 0.0,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              isLoad
                  ? const WaitingScreen()
                  : IconButton(
                      iconSize: 30,
                      onPressed: () {
                        setState(() {
                          isSaved = !isSaved;
                          isLoad = true;
                        });
                        saveThreads();
                      },
                      icon: Column(
                        children: [
                          Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          TextLato(
                            text: isSaved
                                ? applocalization.saved
                                : applocalization.save,
                            paddingAll: 0.0,
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔹 Header Section with User Avatar
  Row threadHeader(AppLocalizations appLocalizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            widget.thread.userProfilePic != null &&
                    widget.thread.userProfilePic!.isNotEmpty
                ? StringImageInCircleAvatar(
                    base64ImageString: widget.thread.userProfilePic!)
                : const CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage("assets/app_logo_half.JPG"),
                  ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextLato(
                    text: widget.thread.userName ?? "userName",
                    paddingAll: 0.0),
                TextLato(
                  text: simplyDateFormat(
                      time: widget.thread.uploadAt, dateOnly: true),
                  paddingAll: 0.0,
                ),
              ],
            ),
          ],
        ),
        if (isSameUser(widget.thread.uid))
          IconButton(
            iconSize: 25,
            onPressed: () {
              alertMessage(appLocalizations.deleteThread,
                  appLocalizations.confirmDeleteThread, () async {
                final res = await agriConnect.deleteThread(
                    widget.thread.threadId, widget.thread.uid);
                showSnackBar(res ?? appLocalizations.deleteThread, context);
              }, context);
            },
            icon: Icon(
              Icons.delete_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
      ],
    );
  }
}
