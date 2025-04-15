import 'package:agrisync/model/app_review_model.dart';
import 'package:agrisync/screens/feedback/submit_review_screen.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String _sortOrder = 'desc';
  int? _filterRating;

  @override
  Widget build(BuildContext context) {
    final baseQuery = FirebaseFirestore.instance.collection('reviews');
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    final stream = (_filterRating != null)
        ? baseQuery
            .where('rating', isEqualTo: _filterRating!)
            .orderBy('timestamp', descending: _sortOrder == 'desc')
            .snapshots()
        : baseQuery
            .orderBy('timestamp', descending: _sortOrder == 'desc')
            .snapshots();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: TextLato(
          text: appLocalizations.userFeedback,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Sort by',
            onSelected: (value) => setState(() => _sortOrder = value),
            itemBuilder: (_) => [
              PopupMenuItem(
                  value: 'asc',
                  child: TextLato(text: appLocalizations.oldestFirst)),
              PopupMenuItem(
                  value: 'desc',
                  child: TextLato(text: appLocalizations.newestFirst)),
            ],
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty)
            // ignore: curly_braces_in_flow_control_structures
            return Center(child: Text(appLocalizations.no_review_available));

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index];
              final review = ReviewModel.fromMap(
                  data.id, data.data() as Map<String, dynamic>);
              final currentUid = FirebaseAuth.instance.currentUser!.uid;
              final hasLiked = review.likes.contains(currentUid);

              return InkWell(
                onLongPress: () {
                  if (isSameUser(review.uid)) {
                    alertMessage(appLocalizations.deleteReview,
                        appLocalizations.confirmDeleteReview, () async {
                      await FirebaseFirestore.instance
                          .collection("reviews")
                          .doc(review.id)
                          .delete();
                    }, context);
                  }
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(review.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        ...List.generate(5, (i) {
                          return Icon(
                            Icons.star,
                            size: 16,
                            color:
                                i < review.rating ? Colors.amber : Colors.grey,
                          );
                        }),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(review.comment),
                        const SizedBox(height: 5),
                        TextLato(
                          text: simplyDateFormat(
                              time: review.timestamp, dateOnly: true),
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        const SizedBox(height: 5),
                        TextLato(
                          text:
                              '${review.likes.length} ${appLocalizations.userAgreedWithReview}',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            hasLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
                            // size: 10,
                          ),
                          onPressed: () => _toggleLike(review),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SubmitReviewScreen()),
        ),
        child: const Icon(
          Icons.edit_note_rounded,
          size: 35,
          // color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _toggleLike(ReviewModel review) async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    final ref = FirebaseFirestore.instance.collection('reviews').doc(review.id);

    if (review.likes.contains(currentUid)) {
      await ref.update({
        'likes': FieldValue.arrayRemove([currentUid]),
      });
    } else {
      await ref.update({
        'likes': FieldValue.arrayUnion([currentUid]),
      });
    }
  }
}
