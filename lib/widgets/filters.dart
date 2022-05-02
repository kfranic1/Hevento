import 'package:flutter/material.dart';
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

  bool _checkedValue1 = false;
  bool _checkedValue2 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: lightGreen,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 75),
            Container(
              width: 280,
              height: 280,
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
                headerStyle: const HeaderStyle(titleTextStyle: TextStyle(fontSize: 14)),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Cijena"),
            Slider(
              activeColor: Colors.white,
              value: widget.filter.maxPrice,
              min: 1000,
              max: 5000,
              divisions: 20,
              label: widget.filter.maxPrice.round().toString(),
              onChanged: (double value) {
                /*setState(() {
                  _priceSlider = value;
                });*/
                widget.filter.maxPrice = value;
              },
            ),
            const SizedBox(height: 10),
            const Text("Broj ljudi"),
            Slider(
              activeColor: Colors.white,
              value: widget.filter.numberOfPeople,
              max: 300,
              divisions: 12,
              label: widget.filter.numberOfPeople.round().toString(),
              onChanged: (double value) {
                /*setState(() {
                  _numOfPeopleSlider = value;
                });*/
                widget.filter.numberOfPeople = value;
              },
            ),
            CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 100),
              title: const Text("Glazba"), //    <-- label
              value: _checkedValue1,
              onChanged: (newValue) {
                setState(() {
                  _checkedValue1 = newValue!;
                });
              },
            ),
            CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 100),
              title: const Text("Konobar"), //    <-- label
              value: _checkedValue2,
              onChanged: (newValue) {
                setState(() {
                  _checkedValue2 = newValue!;
                });
              },
            ),
            /*const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: const Text("Apply changes"),
                onPressed: () =>
                    widget.filter.setAll(selectedDay: _selectedDay, maxPrice: _priceSlider, numberOfPeople: _numOfPeopleSlider),
                style: ElevatedButton.styleFrom(primary: darkGreen),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
