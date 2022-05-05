import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/pages/home/home_page_primary.dart';
import 'package:hevento/pages/home/home_page_secondary.dart';
import 'package:hevento/widgets/custom_app_bar.dart';
import 'package:hevento/widgets/page_wrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      primary: HomePagePrimary(),
      customAppBar: CustomAppBar(),
      secondary: HomePageSecondary(),
    );
  }
}
