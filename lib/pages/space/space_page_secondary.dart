import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/review.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/pages/space/review_dialog.dart';
import 'package:hevento/services/constants.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                  padding: const EdgeInsets.only(left: 15),
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
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async => await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        height: 250,
                        child: appUser == null
                            ? const Center(child: Text("Potrebno je biti prijavljen kako bi ostavio recenziju."))
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
