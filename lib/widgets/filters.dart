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
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  double _priceSlider = 0;
  double _numOfPeopleSlider = 0;

  bool _music = false;
  bool _waiter = false;
  bool _drinks = false;
  bool _food = false;
  bool _security = false;
  bool _specialEffects = false;
  bool _smoking = false;
  double _rating = 0;
  @override
  Widget build(BuildContext context) {
    widget.filter.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
    return LayoutBuilder(builder: (context, constraints) {
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
                  firstDay: DateTime.utc(2022, 1, 1),
                  lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                  shouldFillViewport: true,
                  headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: darkGreen)),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(color: darkGreen, shape: BoxShape.circle),
                    todayTextStyle: todayDateStyle,
                    selectedDecoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
                    selectedTextStyle: selectedDateStyle,
                    cellMargin: const EdgeInsets.all(2),
                    rangeHighlightColor: lightGreen,
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: dayStyle, weekendStyle: dayStyle),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                const SizedBox(
                  width: 15,
                ),
                _rating == 0
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
                          'Ocjena: ' + _rating.toString(),
                          style: filterTxtStyle,
                        ),
                      ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: darkGreen,
                  ),
                  itemSize: 30,
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
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
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    "Cijena: " + _priceSlider.toString() + " HRK",
                    style: filterTxtStyle,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Slider(
                    activeColor: darkGreen,
                    value: widget.filter.price,
                    min: 0,
                    max: 5000,
                    divisions: 20,
                    label: widget.filter.price.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _priceSlider = value;
                      });
                      widget.filter.price = value;
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
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    "Broj ljudi: " + _numOfPeopleSlider.toString(),
                    style: filterTxtStyle,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Slider(
                    activeColor: darkGreen,
                    value: widget.filter.numberOfPeople,
                    max: 300,
                    divisions: 12,
                    label: widget.filter.numberOfPeople.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _numOfPeopleSlider = value;
                      });
                      widget.filter.numberOfPeople = value;
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
                  value: _music,
                  onChanged: (newValue) {
                    setState(() {
                      _music = newValue!;
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
                  value: _waiter,
                  onChanged: (newValue) {
                    setState(() {
                      _waiter = newValue!;
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
                  value: _drinks,
                  onChanged: (newValue) {
                    setState(() {
                      _drinks = newValue!;
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
                  value: _food,
                  onChanged: (newValue) {
                    setState(() {
                      _food = newValue!;
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
                  value: _security,
                  onChanged: (newValue) {
                    setState(() {
                      _security = newValue!;
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
                  value: _specialEffects,
                  onChanged: (newValue) {
                    setState(() {
                      _specialEffects = newValue!;
                    });
                  },
                ),
              ),
              CheckboxListTile(
                activeColor: darkGreen,
                contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                title: const Text("Pušenje", style: filterTxtStyle), //    <-- label
                value: _smoking,
                onChanged: (newValue) {
                  setState(() {
                    _smoking = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  child: const Text("Filtriraj pretragu"),
                  onPressed: () => widget.filter.setAll(selectedDay: _selectedDay, maxPrice: _priceSlider, numberOfPeople: _numOfPeopleSlider),
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
