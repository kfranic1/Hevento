import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/review.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:provider/provider.dart';

class ReviewDialog extends StatefulWidget {
  final Space space;
  final Review? review;
  const ReviewDialog({Key? key, required this.space, required this.review}) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  late Review review;
  late Person appUser;
  @override
  void initState() {
    appUser = context.read<Person?>()!;
    review = widget.review ??
        Review(
          personId: appUser.id,
          spaceId: widget.space.id,
          content: null,
          rating: null,
          time: DateTime.now(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        decoration: const InputDecoration(hintText: "Review"),
        initialValue: review.content,
        maxLines: 5,
        onChanged: (value) => setState(() {
          review.content = value;
        }),
      ),
      const SizedBox(height: 10),
      RatingBar.builder(
        initialRating: review.rating?.toDouble() ?? 0.0,
        minRating: 0,
        direction: Axis.horizontal,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: darkGreen,
        ),
        itemSize: 30,
        onRatingUpdate: (rating) {
          setState(() {
            review.rating = rating.round() == 0 ? null : rating.round();
          });
        },
      ),
      const Expanded(child: SizedBox()),
      ElevatedButton(
        onPressed: () async => await review.createReview(widget.space).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Review succesful")));
          Navigator.of(context).pop();
        }),
        child: const Text("Finish"),
      ),
      const SizedBox(height: 10),
    ]);
  }
}
