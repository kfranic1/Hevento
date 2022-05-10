import 'package:flutter/material.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/extensions/datetime_extension.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class DashboardPageSecondary extends StatefulWidget {
  const DashboardPageSecondary({Key? key}) : super(key: key);

  @override
  State<DashboardPageSecondary> createState() => _DashboardPageSecondaryState();
}

class _DashboardPageSecondaryState extends State<DashboardPageSecondary> {
  DateTime _selectedDay = DateTime.now().trim();
  Space? _space;

  @override
  void initState() {
    try {
      _space = context.read<List<Space>>().firstWhere((element) => element.owner.id == context.read<Person?>()!.id);
    } catch (e) {
      _space = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Person appUser = context.read<Person?>()!;
    List<Space> mySpaces = context.read<List<Space>>().where((element) => element.owner.id == appUser.id).toList();
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        width: 400,
        color: lightGreen,
        child: _space == null
            ? null
            : SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 20),
                  DropdownButton<Space>(
                    value: _space,
                    items: mySpaces
                        .map((space) => DropdownMenuItem<Space>(
                              child: SizedBox(width: constraints.maxWidth * 0.8 - 48, child: Text(space.name)),
                              value: space,
                            ))
                        .toList(),
                    onChanged: (Space? space) {
                      setState(() {
                        _space = space;
                      });
                    },
                    underline: const Divider(height:10, thickness: 2, color: darkGreen),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 225,
                    width: constraints.maxWidth * 0.8,
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
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = DateTime.parse(selectedDay.toString().replaceAll('Z', '').replaceAll('T', ''));
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
                        cellMargin: EdgeInsets.all(0),
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
                    SizedBox(
                      width: constraints.maxWidth * 0.8,
                      child: ListTile(
                        title: Tooltip(
                          message: "Uredi događaj",
                          child: Text(
                            "${_space!.calendar[_selectedDay]}",
                            maxLines: 4,
                          ),
                        ),
                        onTap: () => eventEditor().whenComplete(() => setState(() {})),
                        trailing: IconButton(
                          onPressed: () async {
                            await _space!.handleEvent(_selectedDay, "", remove: true);
                            setState(() {});
                          },
                          icon: const Icon(Icons.close),
                          tooltip: "Ukloni događaj",
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (_space != null)
                    ElevatedButton(
                      child: Text("${_space?.calendar[_selectedDay] != null ? "Uredi" : "Dodaj"} događaj"),
                      onPressed: () => eventEditor().whenComplete(() => setState(() {})),
                    )
                ]),
              ),
      );
    });
  }

  Future eventEditor() async {
    return await showDialog(
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController()..text = _space!.calendar[_selectedDay] ?? "";
          return SizedBox(
            height: 250,
            width: 250,
            child: AlertDialog(
              title: Text("Dodaj opis za događaj u ${_space!.name}, ${DateFormat("dd/MM/yyyy").format(_selectedDay)}"),
              content: TextFormField(
                controller: controller,
                maxLength: 50,
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(controller.text), child: const Text("Završi")),
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Odustani")),
              ],
            ),
          );
        }).then((value) async {
      if (value != null && (value as String).isNotEmpty) await _space!.handleEvent(_selectedDay, value);
    });
  }
}
