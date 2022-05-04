import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hevento/model/filter.dart';
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
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: SpaceGrid(),
              ),
            ),
            SizedBox(
              width: max(constraints.maxWidth * 2 / 7, 400),
              child: Filters(filter: context.read<Filter>()),
            ),
          ],
        );
      }),
    );
  }
}

class SpaceGrid extends StatefulWidget {
  const SpaceGrid({Key? key}) : super(key: key);

  @override
  State<SpaceGrid> createState() => _SpaceGridState();
}

class _SpaceGridState extends State<SpaceGrid> {
  @override
  Widget build(BuildContext context) {
    Filter filter = context.read<Filter>();
    filter.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
    List<SpaceListItem> spaces = context.read<List<SpaceListItem>>().where((element) => element.space.pass(filter)).toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(builder: (context, constraints) {
        return spaces.isEmpty
            ? const Text("No spaces fit the filters")
            : SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: LayoutGrid(
                    gridFit: GridFit.expand,
                    rowSizes:
                        constraints.maxWidth >= 1000 ? List.filled(spaces.length ~/ 2 + spaces.length % 2, auto) : List.filled(spaces.length, auto),
                    columnSizes: constraints.maxWidth >= 1000 ? [1.fr, 1.fr] : [1.fr],
                    rowGap: 20, // equivalent to mainAxisSpacing
                    columnGap: 20,
                    children: spaces,
                  ),
                ),
              );
      }),
    );
  }
}
