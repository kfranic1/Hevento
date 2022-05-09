import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/review.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/pages/space/review_dialog.dart';
import 'package:hevento/services/constants.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class SpacePageSecondary extends StatelessWidget {
  const SpacePageSecondary({Key? key, required this.space}) : super(key: key);

  final Space space;

  @override
  Widget build(BuildContext context) {
    Person? appUser = context.read<Person?>();
    DateTime? selectedDay = context.read<Filter>().selectedDay;
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
                const SizedBox(height: 20),
                Container(
                  width: 380,
                  height: 225,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: selectedDay ?? DateTime.now(),
                    currentDay: selectedDay ?? DateTime.now(),
                    eventLoader: (day) => space.calendar.keys.any((element) => isSameDay(element, day)) ? [("event")] : [],
                    shouldFillViewport: true,
                    availableCalendarFormats: const {CalendarFormat.month: "Month"},
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: HeaderStyle(
                      titleTextStyle:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: darkGreen),
                      titleTextFormatter: (DateTime date, dynamic locale) {
                        return "${months[date.month - 1]} ${date.year}";
                      },
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(color: selectedDay == null ? Colors.white : lightGreen, shape: BoxShape.circle),
                      todayTextStyle: selectedDay == null ? const TextStyle() : selectedDateStyle,
                      selectedDecoration: const BoxDecoration(color: lightGreen, shape: BoxShape.circle),
                      selectedTextStyle: selectedDateStyle,
                      cellMargin: const EdgeInsets.all(2),
                      rangeHighlightColor: lightGreen,
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: dayStyle,
                      weekendStyle: dayStyle,
                      dowTextFormatter: (DateTime date, dynamic locale) {
                        return days[date.weekday - 1];
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  //TODO ovo sam promjenio zbog overflowa
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      if (space.contacts["email"] != null)
                        GestureDetector(
                          onTap: () async => await launchUrl(Uri.parse("mailto:${space.contacts["email"]}")),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.mail,
                                color: darkGreen,
                              ),
                              Text(' ' + space.contacts["email"]!)
                            ],
                          ),
                        ),
                      if (space.contacts["phone"] != null)
                        GestureDetector(
                          onTapDown: (details) async {
                            if (kIsWeb) {
                              Clipboard.setData(ClipboardData(text: space.contacts["phone"]));
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Broj kopiran u međuspremnik")));
                            } else {
                              await launchUrl(Uri.parse("tel:${space.contacts["phone"]}"));
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: darkGreen,
                              ),
                              Text(' ' + space.contacts["phone"]!)
                            ],
                          ),
                        ),
                      if (space.contacts["facebook"] != null)
                        GestureDetector(
                          onTap: () async => await launchUrl(Uri.parse("https:${space.contacts["facebook"]}")),
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.facebook,
                                color: darkGreen,
                              ),
                              Text(' ' + space.contacts["facebook"]!)
                            ],
                          ),
                        ),
                      if (space.contacts["instagram"] != null)
                        GestureDetector(
                          onTap: () async => await launchUrl(Uri.parse("https:${space.contacts["instagram"]}")),
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.instagram,
                                color: darkGreen,
                              ),
                              Text(' ' + space.contacts["instagram"]!)
                            ],
                          ),
                        ),
                      if (space.contacts["website"] != null)
                        GestureDetector(
                          onTap: () async => await launchUrl(Uri.parse("https:${space.contacts["website"]}")),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.web,
                                color: darkGreen,
                              ),
                              Text(' ' + space.contacts["website"]!)
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async => await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        height: 250,
                        child: appUser == null
                            ? const Center(child: Text("Potrebno je biti prijavljen kako bi ostavio recenziju."))
                            : appUser.id == space.owner.id
                                ? const Center(child: Text("Ne možeš ostaviti recenziju na vlastiti oglas."))
                                : FutureBuilder(
                                    future: Review.getReview(personId: appUser.id, spaceId: space.id),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState != ConnectionState.done) return loader;
                                      return ReviewDialog(
                                        space: space,
                                        review: snapshot.hasData ? snapshot.data as Review : null,
                                        editable: true,
                                      );
                                    }),
                      ),
                    ),
                  ),
                  child: const Text("Napiši recenziju"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
