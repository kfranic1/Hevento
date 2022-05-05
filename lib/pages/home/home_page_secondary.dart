import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/widgets/filters.dart';
import 'package:provider/provider.dart';

class HomePageSecondary extends StatelessWidget {
  const HomePageSecondary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: max(constraints.maxWidth * 2 / 7, 400),
        child: Filters(filter: context.read<Filter>()),
      );
    });
  }
}