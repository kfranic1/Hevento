import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/services/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class Filters extends StatefulWidget {
  final Filter filter;
  const Filters({Key? key, required this.filter}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Filter filter = widget.filter;
      return Container(
        height: double.infinity,
        color: lightGreen,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                width: 380,
                height: 225,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: TableCalendar(
                  availableCalendarFormats: const {CalendarFormat.month: "Month"},
                  firstDay: DateTime.utc(2022, 1, 1),
                  lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
                  focusedDay: DateTime.now(),
                  currentDay: filter.selectedDay,
                  calendarFormat: CalendarFormat.month,
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
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    //_focusedDay = focusedDay;
                  },
                  shouldFillViewport: true,
                  headerStyle: const HeaderStyle(
                      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: darkGreen)),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    todayTextStyle: TextStyle(),
                    selectedDecoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
                    selectedTextStyle: selectedDateStyle,
                    cellMargin: EdgeInsets.all(2),
                    rangeHighlightColor: lightGreen,
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(weekdayStyle: dayStyle, weekendStyle: dayStyle),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                const SizedBox(width: 15),
                filter.rating == 0
                    ? const SizedBox(
                        width: 80,
                        child: Text(
                          'Ocjena',
                          style: filterTxtStyle,
                        ),
                      )
                    : SizedBox(
                        width: 80,
                        child: Text(
                          'Ocjena: ' + filter.rating.toString(),
                          style: filterTxtStyle,
                        ),
                      ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                RatingBar.builder(
                  initialRating: 0,
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
                    value: filter.price,
                    min: 0,
                    max: 5000,
                    divisions: 20,
                    label: filter.price.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        filter.price = value;
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
                    value: filter.numberOfPeople,
                    max: 300,
                    divisions: 12,
                    label: filter.numberOfPeople.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        filter.numberOfPeople = value;
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
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );
    });
  }
}
