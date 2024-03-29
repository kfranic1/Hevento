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
  final bool editable;
  const ReviewDialog({Key? key, required this.space, required this.review, this.editable = false}) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  late Review review;
  late Person appUser;
  @override
  void initState() {
    review = widget.review ??
        Review(
          personId: context.read<Person?>()!.id,
          spaceId: widget.space.id,
          content: null,
          rating: null,
          time: DateTime.now(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(border: Border.all(color: darkGreen, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: 120,
            child: SingleChildScrollView(
              child: TextFormField(
                decoration: InputDecoration(hintText: widget.editable ? "Komentar(opcionalno)" : ''),
                initialValue: review.content,
                maxLines: null,
                onChanged: (value) => setState(() {
                  review.content = value;
                }),
                enabled: widget.editable,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: RatingBar.builder(
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
                ignoreGestures: (!widget.editable),
                onRatingUpdate: (rating) {
                  setState(() {
                    review.rating = rating.round() == 0 ? null : rating.round();
                  });
                },
              ),
            ),
          ),
          if (widget.editable)
            ElevatedButton(
              onPressed: () async => await review.createReview(widget.space).whenComplete(() {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Recenzija uspješno poslana.")));
                Navigator.of(context).pop();
              }),
              child: const Text("Pošalji"),
            ),
          const SizedBox(height: 10),
          if (review.id != null) Center(child: Text("Datum: ${review.time.day}/${review.time.month}/${review.time.year}"))
        ]),
      ),
    );
  }
}
