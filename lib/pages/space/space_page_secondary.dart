import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/review.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/extensions/datetime_extension.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class SpacePageSecondary extends StatelessWidget {
  const SpacePageSecondary({
    Key? key,
    required this.space,
  }) : super(key: key);

  final Space space;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: max(constraints.maxWidth * 2 / 7, 400),
        child: Container(
          height: double.infinity,
          color: lightGreen,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  width: 380,
                  height: 225,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    currentDay: DateTime.now(),
                    eventLoader: (day) => space.calendar.keys.any((element) => isSameDay(element, day)) ? [("event")] : [],
                    shouldFillViewport: true,
                    availableCalendarFormats: const {CalendarFormat.month: "Month"},
                    headerStyle: const HeaderStyle(
                        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: darkGreen)),
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(color: darkGreen, shape: BoxShape.circle),
                      todayTextStyle: todayDateStyle,
                      selectedDecoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
                      selectedTextStyle: selectedDateStyle,
                      cellMargin: EdgeInsets.all(2),
                      rangeHighlightColor: lightGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.11,
                  ),
                  child: Column(
                    children: space.contacts.entries
                        .where((element) => element.value != null)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                //if (e.key == "mail") IconButton(onPressed: (), icon: const Icon(Icons.mail)),
                                Icon(
                                  e.key == "email"
                                      ? Icons.mail
                                      : e.key == "instagram"
                                          ? FontAwesomeIcons.instagram
                                          : e.key == "facebook"
                                              ? FontAwesomeIcons.facebook
                                              : e.key == "phone"
                                                  ? Icons.phone
                                                  : Icons.web,
                                  color: darkGreen,
                                ),
                                Text(' ' + e.value!)
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async => await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: ReviewDialog(
                              space: space,
                            ),
                          )),
                  child: const Text("Ostavi recenziju"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewDialog extends StatefulWidget {
  final Space space;
  const ReviewDialog({Key? key, required this.space}) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  int? _rating = 0;
  final TextEditingController _content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Person? appUser = context.read<Person?>();
    return SizedBox(
      height: 250,
      child: appUser == null
          ? const Center(child: Text("You have to be logged in in order to leave a review"))
          : Column(children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Review"),
                controller: _content,
                maxLines: 5,
              ),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: 0,
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
                    _rating = rating.round() == 0 ? null : rating.round();
                  });
                },
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () async => await Review.createReview(
                  appUser,
                  widget.space,
                  _content.text,
                  _rating,
                ),
                child: const Text("Finish"),
              ),
              const SizedBox(height: 10),
            ]),
    );
  }
}
