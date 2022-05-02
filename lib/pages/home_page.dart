import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/widgets/filters.dart';
import 'package:hevento/widgets/space_list_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    Filter filter = context.read<Filter>();
    filter.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
    List<Space> spaces = context.read<List<Space>>();
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: spaces.where((element) => element.pass(filter)).map((e) => SpaceListItem(space: e)).toList(),
                ),
              ),
            ),
            SizedBox(
              width: max(constraints.maxWidth * 2 / 7, 400),
              child: Filters(filter: filter),
            ),
          ],
        );
      }),
    );
  }
}
