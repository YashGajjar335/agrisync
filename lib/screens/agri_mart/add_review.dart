// AddReviewForProduct
// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReviewForProduct extends StatefulWidget {
  final String productId;
  const AddReviewForProduct({super.key, required this.productId});

  @override
  // ignore: library_private_types_in_public_api
  _AddReviewForProductState createState() => _AddReviewForProductState();
}

class _AddReviewForProductState extends State<AddReviewForProduct> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  void _submitReview() async {
    String reviewText = _reviewController.text;

    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: TextLato(text: 'Please provide a rating')),
      );
      return;
    }

    if (reviewText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: TextLato(text: 'Please enter a review')),
      );
      return;
    }

    // Submit logic (send data to Firestore or API)
    final res = await AgriMartServiceUser.instance
        .uploadProductReview(widget.productId, _reviewController.text, _rating);

    if (res == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: TextLato(text: 'Review submitted successfully!')),
      );

      // Clear fields
      setState(() {
        _rating = 0;
        _reviewController.clear();
      });
      Navigator.pop(context);
    } else {
      showSnackBar(res.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AgriSyncIcon(title: 'Add Review')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextLato(text: 'Rate the Product:', fontSize: 18),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your review here...',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReview,
              child: const TextLato(text: 'Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
