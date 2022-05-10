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
        width: 400,
        height: constraints.maxHeight,
        color: lightGreen,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: constraints.maxWidth * 0.8,
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: darkGreen,
                      ),
                      hintText: "Pretraži po imenu",
                      hintStyle: TextStyle(color: darkGreen),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreen, width: 2.0))),
                  onChanged: (value) => setState(() => filter.name = value),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 225,
                width: constraints.maxWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    ),
                  ],
                ),
                child: TableCalendar(
                  availableCalendarFormats: const {CalendarFormat.month: "Month"},
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
                  focusedDay: filter.selectedDay ?? DateTime.now(),
                  currentDay: filter.selectedDay,
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  selectedDayPredicate: (day) {
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
              SizedBox(
                width: constraints.maxWidth * 0.8,
                child: Column(
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Ocjena' + (filter.rating == 0 ? '' : ": " + filter.rating.toString()),
                          style: filterTxtStyle,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: RatingBar.builder(
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
                      ),
                    ]),
                    const SizedBox(height: 20),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Cijena: " + filter.price.toString() + " HRK",
                          style: filterTxtStyle,
                        ),
                      ),
                      Expanded(
                        flex: 3,
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
                    const SizedBox(height: 10),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Broj ljudi" + (filter.numberOfPeople != 0 ? ": " + filter.numberOfPeople.toString() : ""),
                          style: filterTxtStyle,
                        ),
                      ),
                      Expanded(
                        flex: 3,
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
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
              ElevatedButton(
                child: const SizedBox(
                    width: 100,
                    child: Text(
                      "Filtriraj pretragu",
                      textAlign: TextAlign.center,
                    )),
                onPressed: () => filter.apply(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => setState(() {
                  filter.reset();
                  controller.clear();
                }),
                child: const SizedBox(
                    width: 100,
                    child: Text(
                      "Poništi filter",
                      textAlign: TextAlign.center,
                    )),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }
}
