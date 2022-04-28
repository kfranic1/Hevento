import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/widgets/filters.dart';
import 'package:hevento/widgets/space_list_item.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Filter filter = Filter();

  int page = 0;

  @override
  Widget build(BuildContext context) {
    filter.addListener(() {
      setState(() {});
    });
    List<Space> spaces = context.read<List<Space>>();
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: spaces.map((e) => SpaceListItem(space: e)).toList(),
              ),
            ),
          ),
          SizedBox(
            width: max(constraints.maxWidth * 2 / 7, 400),
            child: Filters(filter: filter),
          ),
        ],
      );
    });
  }
}
