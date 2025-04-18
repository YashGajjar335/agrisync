import 'package:agrisync/model/product_review.dart';
import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewCard extends StatefulWidget {
  final ProductReview productReview;
  const ReviewCard({
    super.key,
    required this.productReview,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  String? userName;
  String? userProfilePic;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    final user =
        await AuthServices.instance.getUserInfo(widget.productReview.uid);
    setState(() {
      userName = user['uname'];
      userProfilePic = user['profilePic'];
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return InkWell(
      onLongPress: () async {
        if (isSameUser(widget.productReview.uid)) {
          alertMessage(appLocalizations.deleteReview,
              appLocalizations.confirmDeleteReview, () async {
            await FirebaseFirestore.instance
                .collection(productCollection)
                .doc(widget.productReview.productId)
                .collection(reviewCollection)
                .doc(widget.productReview.reviewId)
                .delete();
            showSnackBar(appLocalizations.deleteReview, context);
          }, context);
        }
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: userName != null && userProfilePic != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: userProfilePic!.isEmpty
                            ? const CircleAvatar(
                                child: Center(child: Icon(Icons.person)),
                              )
                            : StringImageInCircleAvatar(
                                base64ImageString: userProfilePic!),
                        title: TextLato(
                          text: userName!,
                          fontWeight: FontWeight.bold,
                        ),
                        trailing: RatingBarIndicator(
                          rating: widget.productReview.rating,
                          itemBuilder: (context, index) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber),
                          itemCount: 5,
                          itemSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextLato(
                            text: widget.productReview.review,
                            fontSize: 16,
                            color: Colors.black87),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }
}
