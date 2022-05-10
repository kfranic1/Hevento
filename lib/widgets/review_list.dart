import 'package:flutter/material.dart';
import 'package:hevento/model/review.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/pages/space/review_dialog.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/static_functions.dart';

class ReviewList extends StatelessWidget {
  final Space space;
  const ReviewList({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Functions.getReviews(space.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return loader;
          List<Review> reviews = snapshot.data as List<Review>;
          return reviews.isEmpty
              ? const Center(child: Text("Ovaj oglas nema niti jednu recenziju"))
              : SingleChildScrollView(
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: reviews
                        .map((review) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ReviewDialog(space: space, review: review),
                            ))
                        .toList(),
                  ),
                );
        });
  }
}
