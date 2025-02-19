import 'package:agrisync/model/product_review.dart';
import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/widget/review_card.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:rating_summary/rating_summary.dart';

class ProductReviewScreen extends StatefulWidget {
  final String productId;
  const ProductReviewScreen({super.key, required this.productId});

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        children: [
          Column(
            children: [
              const TextLato(
                text: 'Rating & Review',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Products")
                    .doc(widget.productId)
                    .collection("ProductReview")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const WaitingScreen();
                  }

                  if (snapshot.hasData) {
                    var reviews = snapshot.data!.docs
                        .map((doc) => ProductReview.fromSnap(doc))
                        .toList();

                    // Reset counters
                    int totalReviews = reviews.length;
                    int oneStar = 0,
                        twoStar = 0,
                        threeStar = 0,
                        fourStar = 0,
                        fiveStar = 0;
                    double totalRating = 0.0;

                    for (var review in reviews) {
                      int rating = review.rating.toInt();
                      totalRating += rating;
                      switch (rating) {
                        case 1:
                          oneStar++;
                          break;
                        case 2:
                          twoStar++;
                          break;
                        case 3:
                          threeStar++;
                          break;
                        case 4:
                          fourStar++;
                          break;
                        case 5:
                          fiveStar++;
                          break;
                      }
                    }

                    double averageRating =
                        totalReviews == 0 ? 0.0 : totalRating / totalReviews;

                    return Column(
                      children: [
                        RatingSummary(
                          counter: totalReviews,
                          average: averageRating,
                          counterFiveStars: fiveStar,
                          counterFourStars: fourStar,
                          counterThreeStars: threeStar,
                          counterTwoStars: twoStar,
                          counterOneStars: oneStar,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        totalReviews == 0
                            ? const SizedBox(
                                height: 50,
                                child: Center(
                                    child:
                                        TextLato(text: "No Review available")),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: totalReviews,
                                itemBuilder: (context, index) {
                                  return ReviewCard(
                                      productReview: reviews[index]);
                                },
                              ),
                      ],
                    );
                  }

                  return const WaitingScreenWithWarnning();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
