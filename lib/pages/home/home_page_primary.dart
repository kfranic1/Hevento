import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/widgets/space_list_item.dart';
import 'package:provider/provider.dart';

class HomePagePrimary extends StatefulWidget {
  const HomePagePrimary({Key? key}) : super(key: key);

  @override
  State<HomePagePrimary> createState() => _HomePagePrimaryState();
}

class _HomePagePrimaryState extends State<HomePagePrimary> {
  @override
  Widget build(BuildContext context) {
    Filter filter = context.read<Filter>();
    filter.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
    List<SpaceListItem> spaces = context.read<List<SpaceListItem>>().where((element) => element.space.pass(filter)).toList();
    return Padding(
      padding: const EdgeInsets.all(15),
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