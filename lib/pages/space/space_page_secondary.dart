import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/extensions/datetime_extension.dart';
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
                const SizedBox(height: 75),
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now().trim(),
                    currentDay: DateTime.now().trim(),
                    eventLoader: (day) => space.calendar.keys.any((element) => element.sameDay(day)) ? [("event")] : [],
                    shouldFillViewport: true,
                    availableCalendarFormats: const {CalendarFormat.month: "Month"},
                    headerStyle: const HeaderStyle(titleTextStyle: TextStyle(fontSize: 14)),
                    calendarStyle: CalendarStyle(
                      todayDecoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      todayTextStyle: const TextStyle(),
                      markerDecoration: BoxDecoration(color: darkGreen, shape: BoxShape.circle),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Contacts",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: space.contacts.entries
                      .where((element) => element.value != null)
                      .map(
                        (e) => Row(
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
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
