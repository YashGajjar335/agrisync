import 'package:agrisync/model/technology.dart';
import 'package:agrisync/screens/agri_tech/agri_tech_comment_screen.dart';
import 'package:agrisync/services/agri_tech_service.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TechnologyCard extends StatefulWidget {
  final Technology technology;
  const TechnologyCard({
    super.key,
    required this.technology,
  });

  @override
  State<TechnologyCard> createState() => _TechnologyCardState();
}

class _TechnologyCardState extends State<TechnologyCard> {
  final AgriTechService agriTechService = AgriTechService.instance;
  bool isLiked = false;
  bool isSaved = false;
  bool isLoad = true;
  int totalLike = 0;

  @override
  void initState() {
    loadTechnologyData();
    loadUserData();
    super.initState();
  }

  void loadTechnologyData() {
    isLiked = widget.technology.like.contains(AgriTechService.instance.uid);
    isSaved = widget.technology.save.contains(AgriTechService.instance.uid);
    totalLike = widget.technology.like.length;
    if (mounted) {
      setState(() {
        isLoad = false;
      });
    }
  }

  void loadUserData() async {
    final user = await agriTechService.getUser(widget.technology.uid);
    widget.technology.userName = await user['uname'];
    widget.technology.userProfilePic = await user['profilePic'];
    if (mounted) {
      setState(() {});
    }
  }

  void likeTechnology() async {
    bool newLikedState = !isLiked;
    setState(() => isLiked = newLikedState);

    final res = await agriTechService.likeTechnology(widget.technology.techId);
    if (mounted && res != null) {
      // setState(() {}); // Update UI only if necessary
    }
  }

  void saveTechnology() async {
    // Toggle locally for faster UI response
    final previousState = isSaved; // Store previous state
    setState(() => isSaved = !isSaved);

    // Call Firebase and revert on failure
    final result =
        await agriTechService.saveTechnology(widget.technology.techId);
    if (mounted && result == null) {
      setState(() {
        isSaved = previousState;
        isLoad = false;
      }); // Revert if failed
    }
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
            technologyHeader(appLocalizations),
            const SizedBox(height: 5),
            TextLato(
              text: widget.technology.title,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: StringImage(
                base64ImageString: widget.technology.photoUrl,
                fit: BoxFit.contain,
                height: 280,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 5),
            technologyBottom(appLocalizations),
          ],
        ),
      ),
    );
  }

  Widget technologyBottom(AppLocalizations applocalization) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextLato(
          text: widget.technology.description,
        ),
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
                  if (isLiked) {
                    totalLike -= 1;
                  } else {
                    totalLike += 1;
                  }
                  likeTechnology();
                },
              ),
              const Padding(padding: EdgeInsets.all(4)),
              IconButton(
                iconSize: 30,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgriTechCommentScreen(
                        techId: widget.technology.techId,
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
                        saveTechnology();
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

  Row technologyHeader(AppLocalizations appLocalizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            widget.technology.userProfilePic != null &&
                    widget.technology.userProfilePic!.isNotEmpty
                ? StringImageInCircleAvatar(
                    base64ImageString: widget.technology.userProfilePic!)
                : const CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage("assets/app_logo_half.JPG"),
                  ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextLato(
                    text: widget.technology.userName ?? "Specialist",
                    paddingAll: 0.0),
                TextLato(
                  text: simplyDateFormat(
                      time: widget.technology.uploadAt, dateOnly: true),
                  paddingAll: 0.0,
                ),
              ],
            ),
          ],
        ),
        IconButton(
          iconSize: 25,
          onPressed: () {
            alertMessage(appLocalizations.deleteTechnology,
                appLocalizations.confirmDeleteTechnology, () async {
              final res = await agriTechService.deleteTechnology(
                  widget.technology.techId, widget.technology.uid);
              showSnackBar(res ?? appLocalizations.deleteTechnology, context);
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
