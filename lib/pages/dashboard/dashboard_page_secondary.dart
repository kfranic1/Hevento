import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/extensions/datetime_extension.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardPageSecondary extends StatefulWidget {
  const DashboardPageSecondary({Key? key}) : super(key: key);

  @override
  State<DashboardPageSecondary> createState() => _DashboardPageSecondaryState();
}

class _DashboardPageSecondaryState extends State<DashboardPageSecondary> {
  DateTime _selectedDay = DateTime.now().trim();
  Space? _space;

  @override
  Widget build(BuildContext context) {
    Person appUser = context.read<Person?>()!;
    List<Space> mySpaces = context.read<List<Space>>().where((element) => element.owner.id == appUser.id).toList();
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: max(constraints.maxWidth * 2 / 7, 400),
        height: constraints.maxHeight,
        color: lightGreen,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            DropdownButton<Space>(
              value: _space,
              items: mySpaces
                  .map((space) => DropdownMenuItem<Space>(
                        child: Text(space.name),
                        value: space,
                      ))
                  .toList(),
              onChanged: (Space? space) {
                setState(() {
                  _space = space;
                });
              },
            ),
            const SizedBox(height: 20),
            Container(
              width: 380,
              height: 225,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TableCalendar(
                availableCalendarFormats: const {CalendarFormat.month: "Month"},
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
                focusedDay: _selectedDay,
                currentDay: _selectedDay,
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                eventLoader: _space == null
                    ? null
                    : (day) => _space!.calendar.keys.any((element) => isSameDay(element, day))
                        ? [(_space!.calendar[_space!.calendar.keys.firstWhere((element) => isSameDay(day, element))])]
                        : [],
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = DateTime.parse(selectedDay.toString().replaceAll('Z', '').replaceAll('T', ''));
                  });
                },
                shouldFillViewport: true,
                headerStyle: HeaderStyle(
                  titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: darkGreen),
                  titleTextFormatter: (DateTime date, dynamic locale) {
                    return "${months[date.month - 1]} ${date.year}";
                  },
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  todayTextStyle: TextStyle(),
                  selectedDecoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
                  selectedTextStyle: selectedDateStyle,
                  cellMargin: EdgeInsets.all(2),
                  rangeHighlightColor: lightGreen,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: dayStyle,
                    weekendStyle: dayStyle,
                    dowTextFormatter: (DateTime date, dynamic locale) {
                      return days[date.weekday - 1];
                    }),
              ),
            ),
            const SizedBox(height: 20),
            if (_space?.calendar[_selectedDay] != null)
              Row(children: [
                Text("${_space!.calendar[_selectedDay]}"),
                IconButton(
                  onPressed: () async {
                    await _space!.handleEvent(_selectedDay, "", remove: true);
                    setState(() {});
                  },
                  icon: const Icon(Icons.close),
                  tooltip: "Ukloni događaj",
                )
              ]),
            const SizedBox(height: 20),
            if (_space != null)
              ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController controller = TextEditingController();
                          return AlertDialog(
                            title: Text("Dodaj opis za događaj u ${_space!.name}, ${_selectedDay.toString().substring(0, 10)}"),
                            content: TextFormField(
                              controller: controller,
                              maxLines: 4,
                            ),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(context).pop(controller.text), child: const Text("Završi")),
                              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Odustani")),
                            ],
                          );
                        }).then((value) async {
                      if (value != null) await _space!.handleEvent(_selectedDay, value);
                    });
                    setState(() {});
                  },
                  child: Text("Dodaj događaj za ${_space!.name}"))
          ]),
        ),
      );
    });
  }
}
