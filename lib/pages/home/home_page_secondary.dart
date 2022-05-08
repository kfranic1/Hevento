import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/services/constants.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePageSecondary extends StatefulWidget {
  const HomePageSecondary({Key? key}) : super(key: key);

  @override
  State<HomePageSecondary> createState() => _HomePageSecondaryState();
}

class _HomePageSecondaryState extends State<HomePageSecondary> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Filter filter = context.read<Filter>();
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: max(constraints.maxWidth * 2 / 7, 400),
        height: constraints.maxHeight,
        color: lightGreen,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                //initialValue: filter.name,
                controller: controller,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Pretraži po imenu"),
                onChanged: (value) => setState(() => filter.name = value),
              ),
              const SizedBox(height: 10),
              Container(
                width: 380,
                height: 225,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: TableCalendar(
                  availableCalendarFormats: const {CalendarFormat.month: "Month"},
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
                  focusedDay: filter.selectedDay ?? DateTime.now(),
                  currentDay: filter.selectedDay,
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(filter.selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      filter.selectedDay = isSameDay(filter.selectedDay, selectedDay) ? null : selectedDay;
                    });
                  },
                  shouldFillViewport: true,
                  headerStyle: HeaderStyle(
                    titleTextStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: darkGreen),
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
              Row(children: [
                const SizedBox(width: 15),
                SizedBox(
                  width: 80,
                  child: Text(
                    'Ocjena' + (filter.rating == 0 ? '' : ": " + filter.rating.toString()),
                    style: filterTxtStyle,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                RatingBar.builder(
                  initialRating: filter.rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: darkGreen,
                  ),
                  itemSize: 30,
                  onRatingUpdate: (rating) {
                    setState(() {
                      filter.rating = rating;
                    });
                  },
                ),
              ]),
              const SizedBox(
                height: 20,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              Row(children: [
                const SizedBox(width: 15),
                SizedBox(
                  width: 120,
                  child: Text(
                    "Cijena: " + filter.price.toString() + " HRK",
                    style: filterTxtStyle,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Slider(
                    activeColor: darkGreen,
                    value: filter.price.toDouble(),
                    min: 0,
                    max: 5000,
                    divisions: 20,
                    label: filter.price.toString(),
                    onChanged: (double value) {
                      setState(() {
                        filter.price = value.round();
                      });
                    },
                  ),
                ),
              ]),
              const SizedBox(
                height: 10,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              Row(children: [
                const SizedBox(width: 15),
                SizedBox(
                  width: 120,
                  child: Text(
                    "Broj ljudi: " + filter.numberOfPeople.toString(),
                    style: filterTxtStyle,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Slider(
                    activeColor: darkGreen,
                    value: filter.numberOfPeople.toDouble(),
                    max: 300,
                    divisions: 60,
                    label: filter.numberOfPeople.toString(),
                    onChanged: (double value) {
                      setState(() {
                        filter.numberOfPeople = value.round();
                      });
                    },
                  ),
                ),
              ]),
              const SizedBox(
                height: 10,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 35,
                child: CheckboxListTile(
                  activeColor: darkGreen,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                  title: const Text(
                    "Glazba",
                    style: filterTxtStyle,
                  ), //    <-- label
                  value: filter.music,
                  onChanged: (newValue) {
                    setState(() {
                      filter.music = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 35,
                child: CheckboxListTile(
                  activeColor: darkGreen,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                  title: const Text("Konobar", style: filterTxtStyle), //    <-- label
                  value: filter.waiter,
                  onChanged: (newValue) {
                    setState(() {
                      filter.waiter = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 35,
                child: CheckboxListTile(
                  activeColor: darkGreen,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                  title: const Text("Piće", style: filterTxtStyle), //    <-- label
                  value: filter.drinks,
                  onChanged: (newValue) {
                    setState(() {
                      filter.drinks = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 35,
                child: CheckboxListTile(
                  activeColor: darkGreen,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                  title: const Text("Hrana", style: filterTxtStyle), //    <-- label
                  value: filter.food,
                  onChanged: (newValue) {
                    setState(() {
                      filter.food = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 35,
                child: CheckboxListTile(
                  activeColor: darkGreen,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                  title: const Text("Zaštitar", style: filterTxtStyle), //    <-- label
                  value: filter.security,
                  onChanged: (newValue) {
                    setState(() {
                      filter.security = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 35,
                child: CheckboxListTile(
                  activeColor: darkGreen,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                  title: const Text("Specijalni efekti", style: filterTxtStyle), //    <-- label
                  value: filter.specialEffects,
                  onChanged: (newValue) {
                    setState(() {
                      filter.specialEffects = newValue!;
                    });
                  },
                ),
              ),
              CheckboxListTile(
                activeColor: darkGreen,
                contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                title: const Text("Pušenje", style: filterTxtStyle), //    <-- label
                value: filter.smoking,
                onChanged: (newValue) {
                  setState(() {
                    filter.smoking = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  child: const Text("Filtriraj pretragu"),
                  onPressed: () => filter.apply(),
                  style: ElevatedButton.styleFrom(primary: darkGreen),
                ),
              ),
              const SizedBox(height: 20),
              //const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () => setState(() {
                  filter.reset();
                  controller.clear();
                }),
                child: const Text("Poništi filter"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }
}
