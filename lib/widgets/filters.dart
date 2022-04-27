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
  double _currentSliderValue1 = 5000;
  double _currentSliderValue2 = 300;

  bool _checkedValue1 = false;
  bool _checkedValue2 = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Color(0xffd1daa1)),
          child: Column(children: [
            const SizedBox(
              height: 75,
            ),
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
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
            const SizedBox(
              height: 10,
            ),
            const Text("Cijena"),
            Slider(
              activeColor: Colors.white,
              value: _currentSliderValue1,
              max: 5000,
              divisions: 20,
              label: _currentSliderValue1.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue1 = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Broj ljudi"),
            Slider(
              activeColor: Colors.white,
              value: _currentSliderValue2,
              max: 300,
              divisions: 15,
              label: _currentSliderValue2.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue2 = value;
                });
              },
            ),
            CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 100),
              title: const Text("Glazba"), //    <-- label
              value: _checkedValue1,
              onChanged: (newValue) {
                setState(() {
                  _checkedValue1 = !_checkedValue1;
                });
              },
            ),
            CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 100),
              title: const Text("Konobar"), //    <-- label
              value: _checkedValue2,
              onChanged: (newValue) {
                setState(() {
                  _checkedValue2 = !_checkedValue2;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                child: const Text("Apply changes"),
                onPressed: () =>
                    widget.filter.setAll(selectedDay: _selectedDay, maxPrice: _currentSliderValue1, numberOfPeople: _currentSliderValue2),
                style: ElevatedButton.styleFrom(primary: darkGreen),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
