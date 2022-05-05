import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/pages/space/space_page_primary.dart';
import 'package:hevento/pages/space/space_page_secondary.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/extensions/datetime_extension.dart';
import 'package:hevento/services/static_functions.dart';
import 'package:hevento/widgets/page_wrapper.dart';
import 'package:table_calendar/table_calendar.dart';

class SpacePage extends StatelessWidget {
  final Space space;
  const SpacePage({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return PageWrapper(
          primary: SpacePagePrimary(space: space),
          secondary: SpacePageSecondary(space: space),
    );
  }
}
