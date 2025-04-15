import 'package:agrisync/model/app_review_model.dart';
import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitReviewScreen extends StatefulWidget {
  const SubmitReviewScreen({super.key});

  @override
  State<SubmitReviewScreen> createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  final _commentController = TextEditingController();
  int _rating = 0;
  ReviewModel? _existingReview;
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    _loadReview();
  }

  Future<void> _loadReview() async {
    setState(() {
      isLoad = true;
    });
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      _existingReview = ReviewModel.fromMap(doc.id, doc.data());
      _commentController.text = _existingReview!.comment;
      _rating = _existingReview!.rating;
      setState(() {
        isLoad = false;
      });
    }
    setState(() {
      isLoad = false;
    });
  }

  Future<void> _submitReview() async {
    final user = FirebaseAuth.instance.currentUser!;
    final u = await AuthServices.instance.getCurrentUserDetail();
    String userName = u['uname'];
    final review = ReviewModel(
      id: _existingReview?.id ?? '',
      uid: user.uid,
      name: userName,
      comment: _commentController.text,
      rating: _rating,
      likes: _existingReview?.likes ?? [],
      timestamp: DateTime.now(),
    );

    if (_existingReview != null) {
      await FirebaseFirestore.instance
          .collection('reviews')
          .doc(_existingReview!.id)
          .update(review.toMap());
    } else {
      await FirebaseFirestore.instance
          .collection('reviews')
          .add(review.toMap());
    }

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text(_existingReview != null ? 'Review Updated' : 'Review Submitted'),
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: TextLato(
          text: appLocalizations.submitReview,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AgriSyncIcon(
              title: appLocalizations.rateAgriSync,
              size: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: index < _rating ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () => setState(() => _rating = index + 1),
                );
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: appLocalizations.writeYourReview,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReview,
              child: Text(_existingReview != null
                  ? appLocalizations.updateReview
                  : appLocalizations.submitReview),
            ),
          ],
        ),
      ),
    );
  }
}
