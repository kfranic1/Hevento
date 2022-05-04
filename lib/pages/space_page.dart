import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/static_functions.dart';
import 'package:hevento/widgets/custom_divider.dart';
import 'package:table_calendar/table_calendar.dart';

class SpacePage extends StatelessWidget {
  final Space space;
  const SpacePage({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Functions.loadImages(space.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return LayoutBuilder(
            builder: (context, constraints) => Scaffold(
              body: Row(
                children: [
                  const Expanded(child: loader),
                  if (constraints.maxWidth > 800)
                    SizedBox(
                      width: max(constraints.maxWidth * 2 / 7, 400),
                      child: Container(
                        height: double.infinity,
                        color: lightGreen,
                      ),
                    ),
                ],
              ),
            ),
          );
        }
        List<String> ids = snapshot.data as List<String>;
        return LayoutBuilder(
          builder: (context, constraints) => Scaffold(
            endDrawer: (constraints.maxWidth > 800) ? null : Drawer(child: rightSide(constraints)),
            appBar: (constraints.maxWidth > 800)
                ? null
                : AppBar(
                    toolbarHeight: 82,
                    backgroundColor: lightGreen,
                    actions: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.list),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                        ),
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size(double.infinity, 2),
                      child: CustomDivider(
                        divider: Divider(
                          thickness: 2,
                          color: darkGreen,
                          indent: 0,
                          endIndent: 0,
                          height: 2,
                        ),
                        right: lightGreen,
                      ),
                    ),
                  ),
            body: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: SingleChildScrollView(
                      child: Column(
                        //controller: ScrollController(),
                        children: [
                          SizedBox(
                            height: 80,
                            child: Row(
                              children: [
                                Text(
                                  "${space.name}  ${space.minPrice}kn",
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  "${space.rating}/10 ",
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${space.numberOfReviews} glasova",
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => SizedBox(
                                height: 300,
                                //width: 300,
                                child: Image.network(ids[index]),
                              ),
                              separatorBuilder: (context, index) => const SizedBox(width: 10),
                              itemCount: ids.length,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Number of people: ${space.numberOfPeople}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Number of people: ${space.numberOfPeople}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Number of people: ${space.numberOfPeople}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Number of people: ${space.numberOfPeople}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  space.description,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //* Right side of screen
                if (constraints.maxWidth > 800) rightSide(constraints)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget rightSide(BoxConstraints constraints) {
    return SizedBox(
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
                  focusedDay: DateTime.now(),
                  shouldFillViewport: true,
                  availableCalendarFormats: const {CalendarFormat.month: "Month"},
                  headerStyle: const HeaderStyle(titleTextStyle: TextStyle(fontSize: 14)),
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
                            e.key == "mail"
                                ? Icons.mail
                                : e.key == "instagram"
                                    ? FontAwesomeIcons.instagram
                                    : e.key == "facebook"
                                        ? FontAwesomeIcons.facebook
                                        : Icons.phone,
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
    );
  }
}
